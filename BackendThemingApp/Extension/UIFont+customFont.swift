//
//  UIFont+customFont.swift
//  BackendThemingApp
//
//  Created by Jonathan Fuentes on 27/8/24.
//

import Foundation
import UIKit
extension UIFont {
    static func customFont(name: String, size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
