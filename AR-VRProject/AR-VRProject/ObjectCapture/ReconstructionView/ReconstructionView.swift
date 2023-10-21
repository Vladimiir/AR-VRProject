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
    @Binding var showReconstructionView: Bool
    @Binding var progress: Float
    @Binding var reconstractionCompleted: Bool
    @Binding var reconstractionCanceled: Bool
    
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var objectCaptureModel: ObjectCaptureModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    objectCaptureModel.photogrammetrySession?.cancel()
                    dismiss()
                }, label: {
                    Text("Cancel")
                        .font(.headline)
                        .bold()
                        .padding(30)
                        .foregroundColor(.blue)
                })
                .padding(.trailing)

                Spacer()
            }
            
            Spacer()
            
            VStack {
                // BTW, we don't handle errors of the reconstraction
                if reconstractionCompleted && !reconstractionCanceled {
                    ModelView(modelFile: outputFile,
                              endCaptureCallback: {
                        self.objectCaptureModel.reset()
                        showReconstructionView = false
                    })
                } else {
                    HStack {
                        Text("Reconstruction in progress...")
                        
                        Spacer()
                        
                        Text(progress,
                             format: .percent.precision(.fractionLength(0)))
                        .monospacedDigit()
                    }
                    .font(.body)
                    
                    ProgressView(value: progress)
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
    }
}
