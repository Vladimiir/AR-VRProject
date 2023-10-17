//
//  DirectoriesManager.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 15.10.2023.
//

import Foundation

class DirectoriesManager {
    
    static var scanDirectory = createNewScanDirectory()
    
    static var checkpointDirectory: URL? = {
        scanDirectory?.appendingPathComponent("Snapshots/")
    }()
    
    static var imagesDirectory: URL? = {
        scanDirectory?.appendingPathComponent("Images/")
    }()
    
    static var modelsDirectory: URL? = {
        scanDirectory?.appendingPathComponent("Models/")
    }()
    
    static var modelDirectory: URL? = {
        modelsDirectory?.appendingPathComponent("model.usdz")
    }()
    
    private static func createNewScanDirectory() -> URL? {
        guard let documentsFolder = try? FileManager.default.url(for: .documentDirectory,
                                                                 in: .userDomainMask,
                                                                 appropriateFor: nil, create: false) else {
            return nil
        }
        
        let documentScansFolder = documentsFolder.appendingPathComponent("Scans/", isDirectory: true)
        let formatter = ISO8601DateFormatter()
        let timestamp = formatter.string(from: Date())
        let newCaptureDir = documentScansFolder.appendingPathComponent(timestamp, isDirectory: true)
        
        let capturePath = newCaptureDir.path
        do {
            try FileManager.default.createDirectory(atPath: capturePath,
                                                    withIntermediateDirectories: true)
        } catch {
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
