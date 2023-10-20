//
//  ReconstructionView.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 14.10.2023.
//

import SwiftUI
import RealityKit

struct ReconstructionView: View {
    
    let outputFile: URL
    @Binding var progress: Float
    @EnvironmentObject var objectCaptureModel: ObjectCaptureModel
    
    @State private var completed: Bool = false
    @State private var cancelled: Bool = false
    
    var body: some View {
        VStack {
            if completed && !cancelled {
                ModelView(modelFile: outputFile, 
                          endCaptureCallback: { //[weak self] in
//                    self.objectCaptureModel.endCapture()
                })
            } else {
                ProgressView(progress: progress)
            }
        }
    }
}
