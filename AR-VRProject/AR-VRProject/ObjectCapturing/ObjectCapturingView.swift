//
//  ObjectCapturingView.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 12.10.2023.
//

import SwiftUI
import RealityKit

// TODO: rename to container 'ObjectCapture'
struct ObjectCapturingView: View {
    
    @StateObject var vm = ObjectCapturingViewModel()
    
    // TODO: use Swift Concurrency
    var body: some View {
        ObjectCaptureView(session: vm.session,
                          cameraFeedOverlay: { GradientBackground() })
//        .blur(radius: 45)//appModel.showPreviewModel ? 45 : 0)
//        .transition(.opacity)
        
        // 0. ObjectCapturing container view, for the first time we show explanation view
        // 1. explanation view - what we do and how, show explanations in horizontal slider
        // 2. camera screen with frame like in GuidedCapture app
    }
}

private struct GradientBackground: View {
    private let gradient = LinearGradient(
        colors: [.black.opacity(0.4), .clear],
        startPoint: .top,
        endPoint: .bottom
    )
    private let frameHeight: CGFloat = 300

    var body: some View {
        VStack {
            gradient
                .frame(height: frameHeight)

            Spacer()

            gradient
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(height: frameHeight)
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}
