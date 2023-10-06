//
//  ContentView.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 05.10.2023.
//

import SwiftUI
import RealityKit

struct ContentView : View {
   
    @ObservedObject var arViewModel = ARViewModel()
    
    var body: some View {
        TabView {
            getARViewContainer()
                .tabItem {
                    Label("ARView", systemImage: "star")
                }

            RealityKitView()
                .ignoresSafeArea()
                .tabItem {
                    Label("RealityKitView", systemImage: "list.dash")
                }
        }
    }
    
    private func getARViewContainer() -> some View {
        ZStack {
            ARViewContainer(arViewModel: arViewModel)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                VStack {
                    Text("Is Image Recognized?")
                    
                    switch arViewModel.imageRecognizedVar {
                    case false:
                        Text("No")
                            .foregroundColor(.red)
                    case true:
                        Text("Yes")
                            .foregroundColor(.green)
                    }
                    
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
