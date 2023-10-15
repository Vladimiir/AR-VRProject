//
//  ObjectCaptureContainerViewModel.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 12.10.2023.
//

import SwiftUI
import RealityKit

@MainActor
class ObjectCaptureContainerViewModel: ObservableObject {
    
    @Published var session: ObjectCaptureSession
    
    private(set) var photogrammetrySession: PhotogrammetrySession?
    private var directoriesManager = DirectoriesManager()
    
    init() {
        session =  ObjectCaptureSession()
        
        var configuration = ObjectCaptureSession.Configuration()
        //        configuration.isOverCaptureEnabled = true
        
        if let checkpointDirectory = directoriesManager.checkpointDirectory {
            configuration.checkpointDirectory = checkpointDirectory
        }
        
        if let imagesDirectory = directoriesManager.imagesDirectory {
            self.session.start(imagesDirectory: imagesDirectory,
                               configuration: configuration)
        }
    }
    
    func startReconstruction() throws {
        var configuration = PhotogrammetrySession.Configuration()
        
        // Create directories somewhere else
        if let checkpointDirectory = directoriesManager.checkpointDirectory {
            configuration.checkpointDirectory = checkpointDirectory
        }
        
        if let imagesDirectory = directoriesManager.imagesDirectory {
            do {
                photogrammetrySession = try PhotogrammetrySession(input: imagesDirectory,
                                                                  configuration: configuration)
            } catch {
//                logger.error("Reconstructing failed!")
            }
        }
        
//        state = .reconstructing
    }
}
