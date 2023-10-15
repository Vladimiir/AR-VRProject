//
//  ObjectCaptureContainerView.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 12.10.2023.
//

import SwiftUI
import RealityKit

struct ObjectCaptureContainerView: View {
    
    @StateObject var vm = ObjectCaptureContainerViewModel()
    
    // TODO: use Swift Concurrency
    var body: some View {
        if vm.session.userCompletedScanPass {
            VStack {
                ObjectCapturePointCloudView(session: vm.session)
                
                Button(action: {
                    vm.session.finish()
                }, label: {
                    Text("Finish")
                })
                
                // TODO: what to do here?
                // move to reconstraction flow
                // show created model in OS camera
            }
        } else {
            ObjectCaptureView(session: vm.session,
                              cameraFeedOverlay: { GradientBackground() })
    //        .blur(radius: 45)//appModel.showPreviewModel ? 45 : 0)
    //        .transition(.opacity)
            
            if case .ready = vm.session.state {
                Button(action: {
                    vm.session.startDetecting()
                }, label: {
                    Text("Continue")
                })
            } else if case .detecting = vm.session.state {
                Button(action: {
                    vm.session.startCapturing()
                }, label: {
                    Text("Start Capture")
                })
            }
            
            Button {
                vm.session.resetDetection()
            } label: {
                Text("Reset")
            }
        }
        
        // 0. ObjectCapturing container view, for the first time we show explanation view
        // 1. CaptureOverlayView - explanation view - what we do and how, show explanations in horizontal slider
        // 2. camera screen with frame like in GuidedCapture app
        // 3.
        
        // record all tree orbits
        // show progress view
        // show camera with scanned object (like my mug)
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
