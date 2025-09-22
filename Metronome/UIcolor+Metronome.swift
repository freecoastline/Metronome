//
//  UIColor+Metronome.swift
//  Metronome
//
//  Created by ken on 2025/8/30.
//

import SwiftUI
import UIKit

extension UIColor {
    /// Convenience initializer for creating UIColor from RGB values (0-255)
    /// - Parameters:
    ///   - red: Red component (0-255)
    ///   - green: Green component (0-255)
    ///   - blue: Blue component (0-255)
    ///   - alpha: Alpha component (0.0-1.0)
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Red component out of range")
        assert(green >= 0 && green <= 255, "Green component out of range")
        assert(blue >= 0 && blue <= 255, "Blue component out of range")
        assert(alpha >= 0.0 && alpha <= 1.0, "Alpha component out of range")
        
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
}

// MARK: - Theme Colors
extension Color {
    static let metronomeBackground = Color(red: 255/255, green: 251/255, blue: 222/255)
    static let metronomeControl = Color(red: 116/255, green: 155/255, blue: 194/255)
    static let metronomePlayButton = Color(red: 145/255, green: 200/255, blue: 228/255)
    static let metronomeProgress = Color(red: 70/255, green: 130/255, blue: 169/255)
}
