//
//  ARVRToolsList.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 05.10.2023.
//

import SwiftUI
import RealityKit

struct ARVRToolsList: View {
    
    @ObservedObject var vm = ARViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("ARView 👾👀") {
                    ARViewContainer()
                        .ignoresSafeArea()
                }
                
                NavigationLink("ARViewRepresentable") {
                    ARViewRepresentable(vm: vm)
                        .ignoresSafeArea()
                }
                
                NavigationLink("RealityKitView 😵‍💫🥽") {
                    RealityKitView()
                        .ignoresSafeArea()
                }
            }
            .navigationTitle("List of AR/VR tools")
        }
    }
}

#Preview {
    ARVRToolsList()
}
