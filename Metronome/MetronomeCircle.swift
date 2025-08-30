//
//  MetronomeCircle.swift
//  Metronome
//
//  Created by ken on 2025/8/30.
//

import Foundation
import SwiftUI

struct MetronomeCircle:View {
    let circleColor:Color
    let radius:CGFloat
    let iconString:String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(circleColor)
                .frame(width: radius * 2, height: radius * 2)
            Image(systemName: iconString)
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: radius, height: radius)
        }
    }
}

#Preview {
    MetronomeCircle(circleColor: .brown, radius: 50, iconString: "play")
}
