//
//  ReconstructionInProgressView.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 14.10.2023.
//

import SwiftUI
import RealityKit

//struct ReconstructionInProgressView: View {
//    
//    var body: some View {
//        ReconstructionProgressView()
//            .task { // 1
//                var configuration = PhotogrammetrySession.Configuration()
//                configuration.checkpointDirectory = getDocumentsDir()
//                    .appendingPathComponent("Snapshots/") // 3
//                let session = try PhotogrammetrySession( // 2
//                    input: getDocumentsDir().appendingPathComponent("Images/"),
//                    configuration: configuration)
//                try session.process(requests: [ // 4
//                    .modelFile(url: getDocumentsDir().appendingPathComponent("model.usdz"))
//                ])
//                for try await output in session.outputs { // 5
//                    switch output {
//                        case .processingComplete:
//                            handleComplete()
//                            // Handle other Output messages here.
//                    }
//                }
//            }
//    }
//}
