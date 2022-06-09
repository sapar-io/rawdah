//
//  LanguagesView.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 08.06.2022.
//

import Foundation
import UIKit
import Stevia

protocol LanguagesViewDelegate: AnyObject {
    func languageChanged()
}

class LanguagesView: UIView {
    
    // MARK: - Variables
    weak var delegate: LanguagesViewDelegate?
    
    // MARK: - Outlets
    private let kazakhButton: UIButton = {
        let button = UIButton()
        button.setTitle("🇰🇿 Қазақша", for: [])
        button.setTitleColor(.label, for: [])
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemBackground
        return button
    }()
    
    private let russianButton: UIButton = {
        let button = UIButton()
        button.setTitle("🇷🇺 Русский", for: [])
        button.setTitleColor(.label, for: [])
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemBackground
        return button
    }()
    
    private let englishButton: UIButton = {
        let button = UIButton()
        button.setTitle("🇬🇧 English", for: [])
        button.setTitleColor(.label, for: [])
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemBackground
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kazakhButton, russianButton, englishButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 12
        stackView.backgroundColor = .secondarySystemBackground
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Actions
    @objc
    private func kazakhButtonDidTapped() {
        Bundle.setLanguage(lang: "kk")
        delegate?.languageChanged()
    }
    
    @objc
    private func russianButtonDidTapped() {
        Bundle.setLanguage(lang: "ru")
        delegate?.languageChanged()
    }
    
    @objc
    private func englishButtonDidTapped() {
        Bundle.setLanguage(lang: "en")
        delegate?.languageChanged()
    }
}

// MARK: - Setup
extension LanguagesView {
    private func setup() {
        backgroundColor = .black.withAlphaComponent(0.8)
        setupConstraints()
        
        kazakhButton.addTarget(self, action: #selector(kazakhButtonDidTapped), for: .touchUpInside)
        russianButton.addTarget(self, action: #selector(russianButtonDidTapped), for: .touchUpInside)
        englishButton.addTarget(self, action: #selector(englishButtonDidTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        subviews(stackView)
        stackView.fillHorizontally(padding: 24).centerVertically()
        
        kazakhButton.height(44)
        russianButton.height(44)
        englishButton.height(44)
    }
}
