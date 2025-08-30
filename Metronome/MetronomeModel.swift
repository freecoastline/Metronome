//
//  MetronomeModel.swift
//  Metronome
//
//  Created by ken on 2025/8/26.
//

import Foundation
import SwiftUI

class MetronomeModel:ObservableObject {
    @Published var bpm:Int
    @Published var playing:Bool = false
    init(bpm: Int) {
        self.bpm = bpm
    }
}
