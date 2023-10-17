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
    
    @State private var completed: Bool = false
    @State private var cancelled: Bool = false
    
    var body: some View {
        VStack {
            if completed && !cancelled {
                Text("ModelView")
            } else {
                ProgressView(progress: progress)
            }
        }
    }
}
