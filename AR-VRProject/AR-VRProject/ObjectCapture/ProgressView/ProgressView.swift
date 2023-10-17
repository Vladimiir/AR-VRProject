//
//  ProgressView.swift
//  AR-VRProject
//
//  Created by Vladimir Stasenko on 15.10.2023.
//

import SwiftUI

struct ProgressView: View {
    
    var progress: Float
    
    var body: some View {
        Text("\(progress)%")
    }
}
