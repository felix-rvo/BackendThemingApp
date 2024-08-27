//
//  Theme.swift
//  BackendThemingApp
//
//  Created by Jonathan Fuentes on 26/8/24.
//

import Foundation
import UIKit

struct ThemeResponse: Codable {
    let theme: Theme
}

struct Theme: Codable {
    let name: String
    let colors: Colors
    let fonts: Fonts
    let sizes: Sizes
    let tabBar: TabBar

    struct Colors: Codable {
        let primaryBackground: String
        let secondaryBackground: String
        let primaryText: String
        let secondaryText: String
        let buttonBackground: String
        let buttonText: String
        let accentColor: String
        let borderColor: String
    }

    struct Fonts: Codable {
        let headingFont: Font
        let bodyFont: Font
        let buttonFont: Font

        struct Font: Codable {
            let name: String
            let size: CGFloat
            let color: String
        }
    }

    struct Sizes: Codable {
        let buttonHeight: CGFloat
        let buttonCornerRadius: CGFloat
        let padding: CGFloat
        let margin: CGFloat
    }

    struct TabBar: Codable {
        let items: [TabBarItem]

        struct TabBarItem: Codable {
            let title: String
            let icon: String
        }
    }
}
