//
//  ErrorTestAlertView.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 07.06.2022.
//

import Foundation
import UIKit
import Stevia

// MARK: - Delegate
protocol ErrorTestAlertViewDelegate: AnyObject {
    func closeTapped()
    func restartTapped()
}

// MARK: - Main
class ErrorTestAlertView: UIView {
    
    // MARK: - Variables
    weak var delegate: ErrorTestAlertViewDelegate?
    private let index: (Int, Int)
    
    // MARK: - Outlets
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: [])
        button.tintColor = .label
        button.addTarget(self, action: #selector(closeButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "error")
        return imageView
    }()
    
    let successLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Правильных ответов: 10"
        return label
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Неправильных ответов: 2"
        return label
    }()
    
    private let firstTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "«У Аллаха самые прекрасные имена. Посему взывайте к Нему посредством их» (Коран 7:180)."
        return label
    }()
    
    private lazy var secondTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Да поможет вам Аллах выучить все имена и успешно сдать тест для перехода к следующим именам"
        return label
    }()
    
    private let originalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "ان شاء اللهٰ"
        return label
    }()
    
    private lazy var restartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Пересдать тест", for: [])
        button.setTitleColor(.systemGreen, for: [])
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption2)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.borderWidth = 1.0
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(restartButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    init(index: (Int, Int)) {
        self.index = index
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Actions
    @objc
    private func restartButtonDidTapped(_ sender: Any) {
        delegate?.restartTapped()
    }
    
    @objc
    private func closeButtonDidTapped(_ sender: Any) {
        delegate?.closeTapped()
    }
    
    // MARK: - Setup
    private func setup() {
        guard let customFont = UIFont(name: "ScheherazadeNew-Regular", size: 32) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        originalLabel.font = UIFontMetrics.default.scaledFont(for: customFont)
        originalLabel.adjustsFontForContentSizeCategory = true
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        subviews(closeButton, imageView, successLabel, errorLabel, firstTextLabel, secondTextLabel, originalLabel, restartButton)
        
        closeButton.top(24).right(24).size(34)
        
        imageView.Top == safeAreaLayoutGuide.Top + 48
        imageView.centerHorizontally().height(30%).heightEqualsWidth()
        
        successLabel.Top == imageView.Bottom + 12
        successLabel.centerHorizontally()
        
        errorLabel.Top == successLabel.Bottom + 12
        errorLabel.fillHorizontally(padding: 24)
        
        firstTextLabel.Top == errorLabel.Bottom + 12
        firstTextLabel.fillHorizontally(padding: 24)
        
        secondTextLabel.Top == firstTextLabel.Bottom + 12
        secondTextLabel.fillHorizontally(padding: 24)
        
        originalLabel.Top == secondTextLabel.Bottom + 12
        originalLabel.fillHorizontally(padding: 24)
        
        restartButton.height(56).fillHorizontally(padding: 24)
        restartButton.Bottom == self.Bottom - 24
    }
}
