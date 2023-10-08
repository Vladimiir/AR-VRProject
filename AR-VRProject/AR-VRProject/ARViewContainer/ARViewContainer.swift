//
//  ARViewContainer.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 06.10.2023.
//

import SwiftUI
import RealityKit

struct ARViewContainer: View {
    
    @StateObject var vm = ARViewModel()
    
    var body: some View {
        ZStack {
            ARViewRepresentable(vm: vm)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    Text("Is Image Recognized?")
                    
                    Text(vm.imageRecognizedTuple.title)
                        .foregroundColor(vm.imageRecognizedTuple.color)
                    
                    Button(action: {
                        vm.reset()
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

