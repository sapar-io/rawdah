//
//  QuizProgressView.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 06.06.2022.
//

import Foundation
import UIKit
import Stevia

// MARK: - Models
private enum Option {
    case first
    case second
    case third
    case forth
}

// MARK: - Main
class QuizProgressView: UIView {
    
    // MARK: - Variables
    var questionNumber: Int = 0 {
        didSet {
            counterLabel.text = String(format: "test_question_number".localized, String(questionNumber + 1), "27")
            let percentage = (step) * CGFloat(questionNumber) / 100
            progressView.widthConstraint?.constant = UIScreen.main.bounds.width * percentage
        }
    }
    
    private var step: CGFloat = 100 / 27
    
    // MARK: - Outlets
    private let progressView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.3)
        return view
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: "test_question_number".localized, "1", "27")
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup
    private func setup() {
        backgroundColor = .secondarySystemBackground
        subviews(progressView, counterLabel)
        progressView.left(0).top(0).height(100%).width(step%)
        counterLabel.centerInContainer()
    }
}
