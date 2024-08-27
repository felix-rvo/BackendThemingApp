//
//  String+styled.swift
//  BackendThemingApp
//
//  Created by Jonathan Fuentes on 27/8/24.
//

import Foundation
import UIKit

extension String {
    func styled(with style: TextStyle) -> NSAttributedString {
        return self.styled(with: style, alignment: .left, scaled: true)
    }
    
    func styled(with style: TextStyle, alignment: NSTextAlignment = .left, scaled: Bool = true) -> NSAttributedString {

            var attributes: [NSAttributedString.Key: Any] = [
                .font: scaled ? style.scaledFont : style.font,
                .foregroundColor: style.color
            ]

            if let paragraph = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle {
                if let lineHeight = (scaled ? style.scaledLineHeight : style.lineHeight) {
                    paragraph.minimumLineHeight = lineHeight
                    paragraph.maximumLineHeight = lineHeight
                }

                paragraph.alignment = alignment

                attributes[.paragraphStyle] = paragraph
            }

            if let characterSpacing = (scaled ? style.scaledCharacterSpacing : style.characterSpacing) {
                attributes[.kern] = characterSpacing
            }

            let string: String
            switch style.feature {
            case .allCaps:
                string = self.uppercased()
            case .normal:
                string = self
            case .capitalized:
                string = self.capitalized
            case .allSmall:
                string = self.lowercased()
            }

            return NSAttributedString(string: string, attributes: attributes)
        }
}
