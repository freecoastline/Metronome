//
//  MetronomeCircle.swift
//  Metronome
//
//  Created by ken on 2025/8/30.
//

import SwiftUI

struct MetronomeCircle: View {
    let circleColor: Color
    let radius: CGFloat
    let iconString: String
    
    private var accessibilityLabel: String {
        switch iconString {
        case "plus":
            return "Increase BPM"
        case "minus":
            return "Decrease BPM"
        default:
            return "Control button"
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(circleColor)
                .frame(width: radius * 2, height: radius * 2)
                .shadow(color: circleColor.opacity(0.3), radius: 4, x: 0, y: 2)
            
            Image(systemName: iconString)
                .font(.system(size: radius * 0.6, weight: .medium))
                .foregroundColor(.white)
        }
        .accessibilityLabel(accessibilityLabel)
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    MetronomeCircle(circleColor: .brown, radius: 50, iconString: "play")
}
