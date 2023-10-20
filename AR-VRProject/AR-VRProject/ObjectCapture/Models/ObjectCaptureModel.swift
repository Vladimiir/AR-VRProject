//
//  ObjectCaptureModel.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 15.10.2023.
//

import SwiftUI
import RealityKit

@MainActor
class ObjectCaptureModel: ObservableObject {
    
    @Published var session: ObjectCaptureSession?
    @Published var progress: Float = 0
    
    // TODO: add a closure that will trigger in specific cases to let views know about it
    
    /// Handles reconstraction logic off images into 3D model
    private(set) var photogrammetrySession: PhotogrammetrySession?
    
    init() {
        session = ObjectCaptureSession()
        
        var configuration = ObjectCaptureSession.Configuration()
        configuration.isOverCaptureEnabled = true
        
        if let checkpointDirectory = DirectoriesManager.checkpointDirectory {
            configuration.checkpointDirectory = checkpointDirectory
        }
        
        if let imagesDirectory = DirectoriesManager.imagesDirectory {
            self.session?.start(imagesDirectory: imagesDirectory,
                                configuration: configuration)
        }
        
        // Observing for 'stateUpdates' updates and do the next step
        Task {
            if let session {
                for await newState in session.stateUpdates {
                    print("stateUpdates = \(newState)")
                    await stateUpdated()
                }
            }
        }
    }
    
    func stateUpdated() async {
        guard let objectCaptureSession = session else { return }
        
        switch objectCaptureSession.state {
        case .initializing,
                .ready,
                .detecting,
                .capturing,
                .finishing:
            break
        case .completed:
            // Cleans up the session to free GPU and memory resources.
            session = nil
            
            do {
                try await startReconstruction()
            } catch {
                print("Reconstructing failed!")
            }
        case .failed(let error):
            print("error = \(error.localizedDescription)")
        @unknown default:
            break
        }
    }
    
    func startReconstruction() async throws {
        var configuration = PhotogrammetrySession.Configuration()
        
        // Create directories somewhere else
        if let checkpointDirectory = DirectoriesManager.checkpointDirectory {
            configuration.checkpointDirectory = checkpointDirectory
        }
        
        if let imagesDirectory = DirectoriesManager.imagesDirectory {
            photogrammetrySession = try PhotogrammetrySession(input: imagesDirectory,
                                                              configuration: configuration)
            
            if let photogrammetrySession,
               let modelsDirectory = DirectoriesManager.modelsDirectory {
                try photogrammetrySession.process(requests: [
                    .modelFile(url: modelsDirectory.appendingPathComponent("model.usdz"))
                ])
                
                for try await output in photogrammetrySession.outputs {
                    switch output {
                    case .inputComplete,
                            .requestError(_, _),
                            .requestComplete(_, _),
                            .processingCancelled,
                            .invalidSample(id: _, reason: _),
                            .skippedSample(id: _),
                            .automaticDownsampling,
                            .requestProgressInfo(_, _),
                            .stitchingIncomplete:
                        break
                    case .requestProgress(_, fractionComplete: let fractionComplete):
                        progress = Float(fractionComplete)
                    case .processingComplete:
                        // Cleans up the session to free GPU and memory resources.
                        self.photogrammetrySession = nil
                        
                        // Removes snapshots folder to free up space after generating the model.
                        if let checkpointDirectory = DirectoriesManager.checkpointDirectory {
                            DispatchQueue.global(qos: .background).async {
                                try? FileManager.default.removeItem(at: checkpointDirectory)
                            }
                        }
                        
                        
                    @unknown default:
                        print("@unknown default")
                    }
                }
            }
        }
        
        // TOOD: show 'ReconstructionPrimaryView'
        // 'ModelView' if model is ready OR
            // contains 'QLPreviewController' which will show the 3D model
        // 'ReconstructionProgressView' if reconstruction is in progress
            // use there 'for try await output in session.outputs { ... }' to handle all events
    }
}
