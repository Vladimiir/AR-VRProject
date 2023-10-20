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
                if vm.showObjectCapturePointCloudView {
                    VStack {
                        ObjectCapturePointCloudView(session: session)
                        
                        Button(action: {
                            vm.finishButtonAction()
                        }, label: {
                            Text("Finish")
                        })
                        
                        // TODO: what to do here?
                        // 1. move to reconstraction flow
                        // 2. show created model in OS camera
                    }
                } else {
                    ObjectCaptureView(session: session,
                                      cameraFeedOverlay: { GradientBackgroundView() })
//                    .blur(radius: 45)//appModel.showPreviewModel ? 45 : 0)
//                    .transition(.opacity)
                    
                    if vm.canShowContinueButton {
                        Button(action: {
                            vm.continueButtonAction()
                        }, label: {
                            Text("Continue")
                        })
                    } else if vm.canShowStartCaptureButton {
                        Button(action: {
                            vm.startCaptureButtonAction()
                        }, label: {
                            Text("Start Capture")
                        })
                    }
                    
                    Button {
                        vm.resetButtonAction()
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
                ReconstructionView(outputFile: modelDirectory,
                                   progress: $vm.objectCaptureModel.progress)
                .environmentObject(vm.objectCaptureModel)
            }
        }
    }
}
