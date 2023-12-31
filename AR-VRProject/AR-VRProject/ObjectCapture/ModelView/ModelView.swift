//
//  ModelView.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 20.10.2023.
//

import UIKit
import SwiftUI
import ARKit
import QuickLook

struct ModelView: View {
    let modelFile: URL
    let endCaptureCallback: () -> Void
    
    var body: some View {
        ARQuickLookController(modelFile: modelFile,
                              endCaptureCallback: endCaptureCallback)
    }
}

private struct ARQuickLookController: UIViewControllerRepresentable {
    
    let modelFile: URL
    let endCaptureCallback: () -> Void
    
    func makeUIViewController(context: Context) -> QLPreviewControllerWrapper {
        let controller = QLPreviewControllerWrapper()
        controller.qlvc.dataSource = context.coordinator
        controller.qlvc.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> ARQuickLookController.Coordinator {
        return Coordinator(parent: self)
    }
    
    func updateUIViewController(_ uiViewController: QLPreviewControllerWrapper, context: Context) {}
    
    class Coordinator: NSObject, QLPreviewControllerDataSource, QLPreviewControllerDelegate {
        
        let parent: ARQuickLookController
        
        init(parent: ARQuickLookController) {
            self.parent = parent
        }
        
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }
        
        func previewController(_ controller: QLPreviewController,
                               previewItemAt index: Int) -> QLPreviewItem {
            return parent.modelFile as QLPreviewItem
        }
        
        func previewControllerWillDismiss(_ controller: QLPreviewController) {
            parent.endCaptureCallback()
        }
    }
}

/// Need to show AR/Object NavBar, otherwise only fullscreen object will be shown
private class QLPreviewControllerWrapper: UIViewController {
    
    let qlvc = QLPreviewController()
    var qlPresented = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !qlPresented {
            present(qlvc, animated: false, completion: nil)
            qlPresented = true
        }
    }
}
