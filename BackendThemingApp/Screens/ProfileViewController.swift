//
//  ProfileViewController.swift
//  BackendThemingApp
//
//  Created by Jonathan Fuentes on 26/8/24.
//

import UIKit

class ProfileViewController: UIViewController {

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: ThemeManager.shared.currentTheme?.theme.colors.primaryBackground ?? "#FFFFFF")
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = UIColor(hex: ThemeManager.shared.currentTheme?.theme.colors.secondaryBackground ?? "#F0F0F0")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20 // Example number of rows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Profile Item \(indexPath.row)"
        cell.textLabel?.textColor = UIColor(hex: ThemeManager.shared.currentTheme?.theme.colors.primaryText ?? "#000000")
        cell.backgroundColor = UIColor(hex: ThemeManager.shared.currentTheme?.theme.colors.secondaryBackground ?? "#F0F0F0")
        return cell
    }
}
