//
//  ViewController.swift
//  BackendThemingApp
//
//  Created by Jonathan Fuentes on 26/8/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    private var themeURL: URL {
        guard let urlString = ProcessInfo.processInfo.environment["THEME_URL"], let url = URL(string: urlString) else {
            fatalError("Invalid theme URL")
        }
        return url
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load and apply theme
        ThemeManager.shared.loadTheme(from: themeURL) { result in
            switch result {
            case .success(let theme):
                DispatchQueue.main.async {
                    ThemeManager.shared.applyTheme(theme)
                    self.configureTabBar(with: theme)
                }
            case .failure(let error):
                print("Failed to load theme: \(error)")
            }
        }
    }

    private func configureTabBar(with theme: ThemeResponse) {
        tabBar.barTintColor = UIColor(hex: theme.theme.colors.primaryBackground)
        tabBar.tintColor = UIColor(hex: theme.theme.colors.accentColor)

        let tabBarItems = theme.theme.tabBar.items.map { item -> UITabBarItem in
            let iconImage = UIImage(systemName: item.icon)
            return UITabBarItem(title: item.title, image: iconImage, tag: 0)
        }

        let homeVC = HomeViewController()
        homeVC.view.backgroundColor = UIColor(hex: theme.theme.colors.primaryBackground)
        homeVC.tabBarItem = tabBarItems[0]

        let searchVC = SearchViewController()
        searchVC.view.backgroundColor = UIColor(hex: theme.theme.colors.primaryBackground)
        searchVC.tabBarItem = tabBarItems[1]

        let favoritesVC = FavoritesViewController()
        favoritesVC.view.backgroundColor = UIColor(hex: theme.theme.colors.primaryBackground)
        favoritesVC.tabBarItem = tabBarItems[2]

        let profileVC = ProfileViewController()
        profileVC.view.backgroundColor = UIColor(hex: theme.theme.colors.primaryBackground)
        profileVC.tabBarItem = tabBarItems[3]

        viewControllers = [homeVC, searchVC, favoritesVC, profileVC]
    }
}



