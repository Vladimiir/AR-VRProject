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
                        
                        BlueButton(title: "Finish") {
                            vm.finishButtonAction()
                        }
                        .padding(.bottom, 50)
                    }
                } else {
                    ObjectCaptureView(session: session,
                                      cameraFeedOverlay: { GradientBackgroundView() })
                    
                    if vm.canShowContinueButton {
                        BlueButton(title: "Continue") {
                            vm.continueButtonAction()
                        }
                    } else if vm.canShowStartCaptureButton {
                        BlueButton(title: "Start Capture") {
                            vm.startCaptureButtonAction()
                        }
                    }
                    
                    BlueButton(title: "Reset") {
                        vm.resetButtonAction()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 50)
                }
            } else {
                Text("There is no vm.session!")
            }
        }
        .sheet(isPresented: $vm.showReconstructionView) {
            if let modelDirectory = DirectoriesManager.modelDirectory {
                ReconstructionView(outputFile: modelDirectory, 
                                   showReconstructionView: $vm.showReconstructionView,
                                   progress: $vm.objectCaptureModel.progress,
                                   reconstractionCompleted: $vm.objectCaptureModel.reconstractionCompleted,
                                   reconstractionCanceled: $vm.objectCaptureModel.reconstractionCanceled)
                .environmentObject(vm.objectCaptureModel)
            }
        }
    }
}
