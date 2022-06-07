//
//  TopicClosedView.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 30.05.2022.
//

import UIKit
import Stevia

class TopicClosedView: UIView {
    
    // MARK: - Outlets
    private let originalLabel: UILabel = {
        let label = UILabel()
        label.text = "بِسۡمِ ٱللَّهِ‎"
        label.textAlignment = .center
        label.numberOfLines = 0
        
        guard let customFont = UIFont(name: "ScheherazadeNew-Regular", size: 32.0) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        label.font = UIFontMetrics.default.scaledFont(for: customFont)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let firstText: UILabel = {
        let label = UILabel()
        label.text = "topic_close_first_text".localized
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var firstTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [originalLabel, firstText])
        stackView.axis = .vertical
        return stackView
    }()
    
    private let secondText: UILabel = {
        let label = UILabel()
        label.text = "topic_close_second_text".localized
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("topic_close_button".localized, for: [])
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: [])
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold)
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstTextStackView, secondText, button])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.layer.borderWidth = 1.0
        stackView.layer.borderColor = UIColor.systemGreen.cgColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32)
        stackView.layer.cornerRadius = 24
        stackView.clipsToBounds = true
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        setupConstraints()
    }
    
    private func setupConstraints() {
        subviews(mainStackView)
        mainStackView.fillHorizontally(padding: 24).centerVertically()
        button.height(56).fillHorizontally()
    }
}
