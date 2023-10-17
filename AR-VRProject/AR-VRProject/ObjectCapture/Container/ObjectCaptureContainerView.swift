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
    
    var body: some View {
        VStack {
            if let session = vm.objectCaptureModel.session {
                if session.userCompletedScanPass {
                    VStack {
                        ObjectCapturePointCloudView(session: session)
                        
                        Button(action: {
                            session.finish()
                        }, label: {
                            Text("Finish")
                        })
                        
                        // TODO: what to do here?
                        // move to reconstraction flow
                        // show created model in OS camera
                    }
                } else {
                    ObjectCaptureView(session: session,
                                      cameraFeedOverlay: { GradientBackgroundView() })
//                    .blur(radius: 45)//appModel.showPreviewModel ? 45 : 0)
//                    .transition(.opacity)
                    
                    if case .ready = session.state {
                        Button(action: {
                            session.startDetecting()
                        }, label: {
                            Text("Continue")
                        })
                    } else if case .detecting = session.state {
                        Button(action: {
                            session.startCapturing()
                        }, label: {
                            Text("Start Capture")
                        })
                    }
                    
                    Button {
                        session.resetDetection()
                    } label: {
                        Text("Reset")
                    }
                }
            } else {
                Text("There is no vm.session!")
            }
        }
        .sheet(isPresented: $vm.showReconstructionView) {
            if let modelDirectory = DirectoriesManager.modelDirectory {
//                ReconstructionView(outputFile: modelDirectory,
//                                   progress: <#T##Binding<Float>#>)
            }
        }
    }
}
