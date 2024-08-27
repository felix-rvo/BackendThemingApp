//
//  TextStyle.swift
//  BackendThemingApp
//
//  Created by Jonathan Fuentes on 27/8/24.
//

import Foundation
import UIKit

struct TextStyle {
    let font: UIFont
    let textStyle: UIFont.TextStyle
    let color: UIColor
    let lineHeight: CGFloat?
    let characterSpacing: CGFloat?
    let feature: FontFeature

    init(font newFont: UIFont,
         textStyle newTextStyle: UIFont.TextStyle,
         color newColor: UIColor,
         lineHeight newLineHeight: CGFloat? = nil,
         characterSpacing newCharacterSpacing: CGFloat? = nil,
         feature newFeature: FontFeature = .normal) {

        font = newFont
        textStyle = newTextStyle
        color = newColor
        lineHeight = newLineHeight
        characterSpacing = newCharacterSpacing
        feature = newFeature
    }

    var scaledFont: UIFont {
        return font
        // Adjust for text style scaling if needed
    }

    var scaledLineHeight: CGFloat? {
        return lineHeight
    }

    var scaledCharacterSpacing: CGFloat? {
        return characterSpacing
    }

    func with(color newColor: UIColor) -> TextStyle {
        return TextStyle(font: font, textStyle: textStyle, color: newColor, lineHeight: lineHeight, characterSpacing: characterSpacing, feature: feature)
    }
}
