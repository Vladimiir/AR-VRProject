//
//  DirectoriesManager.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 15.10.2023.
//

import Foundation

class DirectoriesManager {
    
    lazy var scanDirectory = createNewScanDirectory()
    
    let checkpointDirectory: URL? = {
//        scanDirectory?.appendingPathComponent("Snapshots/")
        nil
    }()
    
    let imagesDirectory: URL? = {
//        scanDirectory?.appendingPathComponent("Images/")
        nil
    }()
    
//    init() {
////        let scanDirectory = createNewScanDirectory()
//        
//        checkpointDirectory = scanDirectory?.appendingPathComponent("Snapshots/")
//        imagesDirectory = scanDirectory?.appendingPathComponent("Images/")
//    }
    
    private func createNewScanDirectory() -> URL? {
        guard let documentsFolder = try? FileManager.default.url(for: .documentDirectory,
                                                                 in: .userDomainMask,
                                                                 appropriateFor: nil, create: false) else {
            return nil
        }
        
        var documentScansFolder = documentsFolder.appendingPathComponent("Scans/", isDirectory: true)
        let formatter = ISO8601DateFormatter()
        let timestamp = formatter.string(from: Date())
        let newCaptureDir = documentScansFolder.appendingPathComponent(timestamp, isDirectory: true)
        
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
        
        // Check if creating directory at 'capturePath' path was successful
        guard exists && isDir.boolValue else {
            return nil
        }
        
        return newCaptureDir
    }
}
