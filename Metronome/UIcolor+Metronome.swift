//
//  UIcolor+Motronome.swift
//  Metronome
//
//  Created by ken on 2025/8/30.
//

import Foundation
import SwiftUI
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let newRed = CGFloat(red) / 255
        let newGreen = CGFloat(green) / 255
        let newBlue = CGFloat(blue) / 255
        self.init(red:newRed, green: newGreen, blue: newBlue, alpha: alpha)
    }
}
