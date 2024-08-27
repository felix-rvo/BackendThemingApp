//
//  ThemeManager.swift
//  BackendThemingApp
//
//  Created by Jonathan Fuentes on 26/8/24.
//

import Foundation
import UIKit

extension Notification.Name {
    static let themeDidChangeNotification = Notification.Name("themeDidChangeNotification")
}

class ThemeManager {
    static let shared = ThemeManager()
    private init() {}

    private(set) var currentTheme: ThemeResponse?

    func loadTheme(from url: URL, completion: @escaping (Result<ThemeResponse, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "ThemeManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }

            do {
                let theme = try JSONDecoder().decode(ThemeResponse.self, from: data)
                completion(.success(theme))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func applyTheme(_ theme: ThemeResponse) {
        self.currentTheme = theme
        NotificationCenter.default.post(name: .themeDidChangeNotification, object: nil)
    }
}
