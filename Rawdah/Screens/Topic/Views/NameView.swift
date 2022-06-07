//
//  NameView.swift
//  99Names
//
//  Created by Sapar Jumabekov on 27.05.2022.
//

import Foundation
import UIKit
import Stevia

class NameView: UIView {
    
    // MARK: - Outlets
    private let originalLabel: UILabel = {
        let label = UILabel()
        label.text = "original"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let transcriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "transcription"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private let translateLabel: UILabel = {
        let label = UILabel()
        label.text = "translate"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transcriptionLabel, translateLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let checkMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.seal.fill")
        imageView.tintColor = .systemGreen
        return imageView
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
    
    // MARK: - Configure
    func configure(name: Name, isFinish: Bool) {
        originalLabel.text = name.original
        transcriptionLabel.text = "\(name.number). \(name.transcription)"
        translateLabel.text = name.translate
        checkMarkImageView.isHidden = !isFinish
        
        layer.borderWidth = isFinish ? 1.0 : 0
        layer.borderColor = UIColor.systemGreen.cgColor
    }
}

// MARK: - Setup
extension NameView {
    private func setup() {
        backgroundColor = .systemBackground
        
        layer.cornerRadius = 12
        clipsToBounds = true
        
        guard let customFont = UIFont(name: "ScheherazadeNew-Regular", size: UIFont.labelFontSize) else {
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
        subviews(originalLabel, textStackView, checkMarkImageView)
        originalLabel.fillHorizontally().top(0).height(40%)
        textStackView.fillHorizontally(padding: 8)
        textStackView.Top == originalLabel.Bottom + 8
        checkMarkImageView.size(24).top(4).right(4)
    }
}
