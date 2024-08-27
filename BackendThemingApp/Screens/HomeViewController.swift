//
//  HomeViewController.swift
//  BackendThemingApp
//
//  Created by Jonathan Fuentes on 26/8/24.
//

import UIKit

class HomeViewController: UIViewController {

    private let stackView = UIStackView()
    private let tableView = UITableView()
    private let headingLabel = UILabel()
    private let bodyLabel = UILabel()
    private let themedButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Apply theme to the view
        updateTheme()
        
        setupStackView()
        setupHeadingLabel()
        setupBodyLabel()
        setupThemedButton()
        setupTableView()
        
        // Observe theme changes
        NotificationCenter.default.addObserver(self, selector: #selector(themeDidChange(_:)), name: .themeDidChangeNotification, object: nil)
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = CGFloat(ThemeManager.shared.currentTheme?.theme.sizes.margin ?? 20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(ThemeManager.shared.currentTheme?.theme.sizes.padding ?? 20)),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(ThemeManager.shared.currentTheme?.theme.sizes.padding ?? 20)),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(ThemeManager.shared.currentTheme?.theme.sizes.padding ?? 20)),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -CGFloat(ThemeManager.shared.currentTheme?.theme.sizes.padding ?? 20))
        ])
    }

    private func setupHeadingLabel() {
        headingLabel.text = "Welcome to Home"
        headingLabel.attributedText = "Welcome to Home".styled(with: TextStyle(
            font: UIFont(name: ThemeManager.shared.currentTheme?.theme.fonts.headingFont.name ?? "HelveticaNeue-Italic", size: CGFloat(ThemeManager.shared.currentTheme?.theme.fonts.headingFont.size ?? 20))!, textStyle: .largeTitle,
            color: UIColor(hex: ThemeManager.shared.currentTheme?.theme.fonts.headingFont.color ?? "#333333")
        ))
        headingLabel.textAlignment = .center
        
        stackView.addArrangedSubview(headingLabel)
    }

    private func setupBodyLabel() {
        bodyLabel.text = "Here is some introductory text to get you started."
        bodyLabel.attributedText = bodyLabel.text?.styled(with: TextStyle(
            font: UIFont(name: ThemeManager.shared.currentTheme?.theme.fonts.bodyFont.name ?? "Helvetica", size: CGFloat(ThemeManager.shared.currentTheme?.theme.fonts.bodyFont.size ?? 16))!, textStyle: .callout,
            color: UIColor(hex: ThemeManager.shared.currentTheme?.theme.fonts.bodyFont.color ?? "#666666")
        ))
        bodyLabel.numberOfLines = 0
        bodyLabel.textAlignment = .center
        
        stackView.addArrangedSubview(bodyLabel)
    }

    private func setupThemedButton() {
        themedButton.setTitle("Click Me", for: .normal)
        themedButton.backgroundColor = UIColor(hex: ThemeManager.shared.currentTheme?.theme.colors.buttonBackground ?? "#000000")
        themedButton.setTitleColor(UIColor(hex: ThemeManager.shared.currentTheme?.theme.colors.buttonText ?? "#FFFFFF"), for: .normal)
        themedButton.titleLabel?.font = UIFont(name: ThemeManager.shared.currentTheme?.theme.fonts.buttonFont.name ?? "Helvetica-Bold", size: CGFloat(ThemeManager.shared.currentTheme?.theme.fonts.buttonFont.size ?? 18))
        themedButton.layer.cornerRadius = CGFloat(ThemeManager.shared.currentTheme?.theme.sizes.buttonCornerRadius ?? 12)
        
        stackView.addArrangedSubview(themedButton)
    }

    private func setupTableView() {
        tableView.backgroundColor = UIColor(hex: ThemeManager.shared.currentTheme?.theme.colors.secondaryBackground ?? "#F5F5F5")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(tableView)
        
        // Constraint for table view height
        tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    @objc private func themeDidChange(_ notification: Notification) {
        updateTheme()
    }
    
    private func updateTheme() {
        guard let theme = ThemeManager.shared.currentTheme else { return }
        
        view.backgroundColor = UIColor(hex: theme.theme.colors.primaryBackground)
        stackView.spacing = CGFloat(theme.theme.sizes.margin)
        
        headingLabel.attributedText = "Welcome to Home".styled(with: TextStyle(
            font: UIFont(name: theme.theme.fonts.headingFont.name ?? "Helvetica-Bold", size: CGFloat(theme.theme.fonts.headingFont.size))!, textStyle: .callout,
            color: UIColor(hex: theme.theme.fonts.headingFont.color)
        ))

        bodyLabel.attributedText = bodyLabel.text?.styled(with: TextStyle(
            font: UIFont(name: theme.theme.fonts.bodyFont.name ?? "Helvetica", size: CGFloat(theme.theme.fonts.bodyFont.size))!, textStyle: .body,
            color: UIColor(hex: theme.theme.fonts.bodyFont.color)
        ))

        themedButton.backgroundColor = UIColor(hex: theme.theme.colors.buttonBackground)
        themedButton.setTitleColor(UIColor(hex: theme.theme.colors.buttonText), for: .normal)
        themedButton.titleLabel?.font = UIFont(name: theme.theme.fonts.buttonFont.name ?? "Helvetica-Bold", size: CGFloat(theme.theme.fonts.buttonFont.size))
        themedButton.layer.cornerRadius = CGFloat(theme.theme.sizes.buttonCornerRadius)
        
        tableView.backgroundColor = UIColor(hex: theme.theme.colors.secondaryBackground)
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeDidChangeNotification, object: nil)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20 // Número de filas de ejemplo
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let theme = ThemeManager.shared.currentTheme {
            cell.textLabel?.text = "Item \(indexPath.row)"
            cell.textLabel?.textColor = UIColor(hex: theme.theme.colors.primaryText)
            cell.backgroundColor = UIColor(hex: theme.theme.colors.secondaryBackground)
        }
        return cell
    }
}
