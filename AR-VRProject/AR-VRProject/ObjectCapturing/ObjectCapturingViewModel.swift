//
//  ObjectCapturingViewModel.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 12.10.2023.
//

import SwiftUI
import RealityKit

@MainActor
class ObjectCapturingViewModel: ObservableObject {
    
    @Published var session: ObjectCaptureSession
    
    init() {
        session =  ObjectCaptureSession()
        
        var configuration = ObjectCaptureSession.Configuration()
//        configuration.isOverCaptureEnabled = true
        
        if let url = createNewScanDirectory() {
            configuration.checkpointDirectory = url.appendingPathComponent("Snapshots/")
            self.session.start(imagesDirectory: url.appendingPathComponent("Images/"),
                               configuration: configuration)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.session.startDetecting()
            }
        }
    }
    
    func createNewScanDirectory() -> URL? {
        guard let capturesFolder = rootScansFolder() else {
//            logger.error("Can't get user document dir!")
            return nil
        }

        let formatter = ISO8601DateFormatter()
        let timestamp = formatter.string(from: Date())
        let newCaptureDir = capturesFolder.appendingPathComponent(timestamp, isDirectory: true)

//        logger.log("Creating capture path: \"\(String(describing: newCaptureDir))\"")
        let capturePath = newCaptureDir.path
        do {
            try FileManager.default.createDirectory(atPath: capturePath,
                                                    withIntermediateDirectories: true)
        } catch {
//            logger.error("Failed to create capturepath=\"\(capturePath)\" error=\(String(describing: error))")
            return nil
        }
        var isDir: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: capturePath, isDirectory: &isDir)
        guard exists && isDir.boolValue else {
            return nil
        }

        return newCaptureDir
    }
    
    func rootScansFolder() -> URL? {
        guard let documentsFolder =
                try? FileManager.default.url(for: .documentDirectory,
                                             in: .userDomainMask,
                                             appropriateFor: nil, create: false) else {
            return nil
        }
        return documentsFolder.appendingPathComponent("Scans/", isDirectory: true)
    }
}
