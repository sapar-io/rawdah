//
//  SettingsViewController.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import UIKit
import Stevia

struct SettingsSection {
    let title: String
    let options: [SettingsOption]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let handler: (() -> Void)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let handler: (() -> Void)
    var isOn: Bool
}

protocol SettingsViewControllerDelegate: AnyObject {
    func languageChanged()
}

class SettingsViewController: UIViewController {
    
    // MARK: - Variables
    private var models = [SettingsSection]()
    weak var delegate: SettingsViewControllerDelegate?

    // MARK: - Outlets
    private lazy var tableView: UITableView = {
        var table = UITableView(frame: view.bounds, style: .insetGrouped)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configure()
    }
    
    // MARK: - Actions
    @objc private func closeDidTapped() {
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func configure() {
        let privacyPolicyURL = URL(string: "https://pages.flycricket.io/rawdah-1/privacy.html")
        let termsURL = URL(string: "https://pages.flycricket.io/rawdah-1/terms.html")
        let instaUrl = URL(string: "https://instagram.com/rawdah.app")
        
        models.append(SettingsSection(title: "settings_support".localized, options: [
            SettingsOption(title: "sapar@startcode.io", icon: UIImage(systemName: "envelope")) {
                UIApplication.shared.open(URL(string: "mailto:sapar@startcode.io")!)
            },
            SettingsOption(title: "settings_policy".localized, icon: UIImage(systemName: "lock.shield")) {
                guard let url = privacyPolicyURL, UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url)
            },
            SettingsOption(title: "settings_agreement".localized, icon: UIImage(systemName: "doc.text")) {
                guard let url = termsURL, UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url)
            }
        ]))
        
        models.append(SettingsSection(title: "settings_languages".localized, options: [
            SettingsOption(title: "🇰🇿 Қазақша".localized, icon: nil) {
                self.changeLanguage("kk")
            },
            SettingsOption(title: "🇷🇺 Русский", icon: nil) {
                self.changeLanguage("ru")
            },
            SettingsOption(title: "🇬🇧 English".localized, icon: nil) {
                self.changeLanguage("en")
            }
        ]))
        
        models.append(SettingsSection(title: "settings_others".localized, options: [
            SettingsOption(title: "Instagram", icon: UIImage(systemName: "camera")) {
                guard let url = instaUrl, UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url)
            }
        ]))
        tableView.reloadData()
    }
    
    private func changeLanguage(_ lang: String) {
        dismiss(animated: true)
        Bundle.setLanguage(lang: lang)
        delegate?.languageChanged()
    }
}

// MARK: - Setup
extension SettingsViewController {
    private func setup() {
        navigationItem.title = "settings_title".localized
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
               style: .plain,
               target: self,
               action: #selector(closeDidTapped))
        view.backgroundColor = .systemBackground
        
        SettingsCell.registerWithoutNib(for: tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.subviews(tableView)
        tableView.fillHorizontally()
        tableView.Top == view.safeAreaLayoutGuide.Top
        tableView.Bottom == view.safeAreaLayoutGuide.Bottom
    }
}

// MARK: - Table View Delegate
extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
}

// MARK: - Table View DataSource
extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        let cell = SettingsCell.dequeue(tableView, for: indexPath)
        cell.configure(with: model)
        return cell
    }
}
