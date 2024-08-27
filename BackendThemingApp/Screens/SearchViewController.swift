//
//  SearchViewController.swift
//  BackendThemingApp
//
//  Created by Jonathan Fuentes on 26/8/24.
//

import UIKit

class SearchViewController: UIViewController {

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apply theme to the view
        updateTheme()

        // Observe theme changes
        NotificationCenter.default.addObserver(self, selector: #selector(themeDidChange(_:)), name: .themeDidChangeNotification, object: nil)
    }

    private func setupTableView(with theme: ThemeResponse) {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = UIColor(hex: theme.theme.colors.secondaryBackground)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    @objc private func themeDidChange(_ notification: Notification) {
        updateTheme()
    }
    
    private func updateTheme() {
        guard let theme = ThemeManager.shared.currentTheme else { return }
        view.backgroundColor = UIColor(hex: theme.theme.colors.primaryBackground)
        setupTableView(with: theme)
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeDidChangeNotification, object: nil)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20 // Example number of rows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let theme = ThemeManager.shared.currentTheme {
            cell.textLabel?.text = "Search Item \(indexPath.row)"
            cell.textLabel?.textColor = UIColor(hex: theme.theme.colors.primaryText)
            cell.backgroundColor = UIColor(hex: theme.theme.colors.secondaryBackground)
        }
        return cell
    }
}
