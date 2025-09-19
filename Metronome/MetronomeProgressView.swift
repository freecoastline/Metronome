//
//  MetronomeProgressView.swift
//  Metronome
//
//  Created by ken on 2025/8/30.
//

import Foundation
import SwiftUI

struct MetronomeProgressView:View {
    let bpmValue:Int
    let totalValue = 200.0
    let indicatorRadius = 15.0
    let startOffset = -190.0
    var body: some View {
        ZStack {
            Divider()
            Circle().fill(Color.init(uiColor: .init(red: 70, green: 130, blue: 169, alpha: 1.0)))
                .frame(width:indicatorRadius, height: indicatorRadius)
                .offset(x:CGFloat(startOffset + (CGFloat(bpmValue - 30) / totalValue) * 380), y: 0)
        }
    }
}


#Preview {
    MetronomeProgressView(bpmValue: 150)
}

