//
//  UIColor+hex.swift
//  BackendThemingApp
//
//  Created by Jonathan Fuentes on 26/8/24.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        if hexSanitized.count == 6 {
            hexSanitized = "FF" + hexSanitized
        }
        var rgb: UInt32 = 0
        Scanner(string: hexSanitized).scanHexInt32(&rgb)
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        let alpha = CGFloat((rgb >> 24) & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
