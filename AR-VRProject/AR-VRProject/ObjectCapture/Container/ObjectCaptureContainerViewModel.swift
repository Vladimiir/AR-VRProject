//
//  ObjectCaptureContainerViewModel.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 12.10.2023.
//

import SwiftUI
import RealityKit
import Combine

@MainActor
class ObjectCaptureContainerViewModel: ObservableObject {
    
    @Published var showReconstructionView = false
    
    /// Handles all capturing and reconstration logic
    @Published var objectCaptureModel = ObjectCaptureModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addListeners()
    }
    
    private func addListeners() {
        objectCaptureModel.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        .store(in: &cancellables)
    }
}
