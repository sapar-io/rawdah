//
//  SuccessTestAlertView.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 07.06.2022.
//

import Foundation
import UIKit
import Stevia

// MARK: - Delegate
protocol SuccessTestAlertViewDelegate: AnyObject {
    func nextTapped()
    func shareTapped()
}

// MARK: - Main
class SuccessTestAlertView: UIView {
    
    // MARK: - Variables
    weak var delegate: SuccessTestAlertViewDelegate?
    private let index: (Int, Int)
    
    // MARK: - Outlets
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "success")
        return imageView
    }()
    
    private let originalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "‎ما شاء الله‎"
        return label
    }()
    
    private let firstTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "test_success_first_text".localized
        return label
    }()
    
    private lazy var secondTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = String(format: "test_success_second_text".localized, String(index.0), String(index.1))
        return label
    }()
    
    private lazy var thirdTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = String(format: "test_success_third_text".localized, String(99 - index.1))
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("test_success_next_button".localized, for: [])
        button.setTitleColor(.white, for: [])
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption2)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(nextButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: [])
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption2)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.tintColor = .systemGreen
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.borderWidth = 1.0
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(shareButtonDidTapped), for: .touchUpInside)
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
    private func nextButtonDidTapped(_ sender: Any) {
        delegate?.nextTapped()
    }
    
    @objc
    private func shareButtonDidTapped(_ sender: Any) {
        delegate?.shareTapped()
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
        subviews(imageView, originalLabel, firstTextLabel, secondTextLabel, thirdTextLabel, nextButton, shareButton)
        
        imageView.Top == safeAreaLayoutGuide.Top + 48
        imageView.centerHorizontally().height(30%).heightEqualsWidth()
        
        originalLabel.Top == imageView.Bottom + 12
        originalLabel.centerHorizontally()
        
        firstTextLabel.Top == originalLabel.Bottom + 12
        firstTextLabel.fillHorizontally(padding: 24)
        
        secondTextLabel.Top == firstTextLabel.Bottom + 12
        secondTextLabel.fillHorizontally(padding: 24)
        
        thirdTextLabel.Top == secondTextLabel.Bottom + 12
        thirdTextLabel.fillHorizontally(padding: 24)
        
        shareButton.size(56).right(24)
        shareButton.Bottom == self.Bottom - 24
        
        nextButton.height(56).left(24)
        nextButton.Bottom == self.Bottom - 24
        nextButton.Right == shareButton.Left - 12
    }
}
