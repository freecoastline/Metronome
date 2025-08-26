//
//  MetronomeViewModel.swift
//  Metronome
//
//  Created by ken on 2025/8/26.
//

import Foundation

class MetronomeViewModel {
    @Published var model = MetronomeModel()
    
    func currentModel() -> MetronomeModel {
        model
    }
    
}
