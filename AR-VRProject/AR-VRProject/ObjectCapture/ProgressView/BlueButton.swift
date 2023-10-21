//
//  BlueButton.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 21.10.2023.
//

import SwiftUI

struct BlueButton: View {
    
    let title: String
    let action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
        })
        .font(.body)
        .fontWeight(.bold)
        .foregroundColor(.white)
        .padding(.horizontal, 25)
        .padding(.vertical, 20)
        .background(.blue)
        .clipShape(Capsule())
    }
}
