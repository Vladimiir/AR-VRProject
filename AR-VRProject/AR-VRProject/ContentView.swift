//
//  ContentView.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 05.10.2023.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    @ObservedObject var arViewModel = ARViewModel()
    @ObservedObject var realityKitViewModel = RealityKitViewModel()
    
    var body: some View {
        NavigationStack {
            NavigationLink("ARView") {
                getARViewContainer()
            }
            
            NavigationLink("RealityKitView") {
                RealityKitView(vm: realityKitViewModel)
                    .ignoresSafeArea()
            }
        }
    }
    
    private func getARViewContainer() -> some View {
        ZStack {
            ARViewContainer(vm: arViewModel)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                VStack {
                    Text("Is Image Recognized?")
                    
                    Text(arViewModel.imageRecognizedTuple.title)
                        .foregroundColor(arViewModel.imageRecognizedTuple.color)
                    
                    Button(action: {
                        arViewModel.reset()
                    }, label: {
                        Text("Reset")
                    })
                }
                .font(.title)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(.regularMaterial))
            }
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    ContentView()
}
