//
//  TrueFalseTestView.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 06.06.2022.
//

import Foundation
import UIKit
import Stevia

// MARK: - Models
private enum Option: Int {
    case first
    case second
}

// MARK: - Delegate
protocol TrueFalseTestDelegate: AnyObject {
    func optionSelected(status: OptionStatus)
}

// MARK: - Main
class TrueFalseTestView: UIView {
    
    // MARK: Model
    struct Model {
        let name: Name
        let isCorrect: Bool
    }
    
    // MARK: - Variables
    private let index: (Int, Int)
    private let realm = RealmDB()
    private var models: [Model] = []
    private var currentIndex: Int = 0
    weak var delegate: TrueFalseTestDelegate?
    
    // MARK: - Outlets
    private let originalLabel: UILabel = {
        let label = UILabel()
        label.text = "original"
        return label
    }()
    
    private let transcriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "transcriptionLabel"
        return label
    }()
    
    private let translateLabel: UILabel = {
        let label = UILabel()
        label.text = "translateLabel"
        return label
    }()
    
    private let firstDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemFill
        return view
    }()
    
    private let successImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    let successCounterLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .systemGreen
        return label
    }()
    
    private lazy var successStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [successImageView, successCounterLabel])
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private let errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "xmark")
        imageView.tintColor = .systemRed
        return imageView
    }()
    
    let errorCounterLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .systemRed
        return label
    }()
    
    private lazy var errorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [errorImageView, errorCounterLabel])
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var counterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [successStackView, errorStackView])
        stackView.alignment = .center
        stackView.spacing = 24
        return stackView
    }()
    
    private let secondDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemFill
        return view
    }()
    
    private lazy var firstOptionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Верно", for: [])
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption2)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.label, for: [])
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(firstOptionDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondOptionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Неверно", for: [])
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption2)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.label, for: [])
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(secondOptionDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var allButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstOptionButton, secondOptionButton])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Init
    init(index: (Int, Int)) {
        self.index = index
        
        for i in index.0 ... index.1 {
            let name = AllNames[i - 1]
            models.append(.init(name: name, isCorrect: true))
            
            let mistakeNameTranslate = AllNames.filter{ $0.number != name.number }.shuffled().first?.translate ?? "Error"
            var mistakeName = name
            mistakeName.translate = mistakeNameTranslate
            models.append(.init(name: mistakeName, isCorrect: false))
        }
        
        models = models.shuffled()
        
        super.init(frame: .zero)
        setup()
        setupTest(isInitial: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private Methods
    func setupTest(isInitial: Bool = false) {
        if !isInitial {
            colorButton(nil)
            currentIndex += 1
        }
        
        let model = models[currentIndex]
        
        originalLabel.text = model.name.original
        transcriptionLabel.text = model.name.transcription
        translateLabel.text = model.name.translate
    }
    
    func restart() {
        colorButton(nil)
        currentIndex = 0
        models = []
        
        for i in index.0 ... index.1 {
            let name = AllNames[i - 1]
            models.append(.init(name: name, isCorrect: true))
            
            let mistakeNameTranslate = AllNames.filter{ $0.number != name.number }.shuffled().first?.translate ?? "Error"
            var mistakeName = name
            mistakeName.translate = mistakeNameTranslate
            models.append(.init(name: mistakeName, isCorrect: false))
        }
        
        models = models.shuffled()
        setupTest(isInitial: true)
    }
    
    private func optionTapped(_ option: Option) {
        colorButton(option)
    }
    
    private func colorButton(_ option: Option?) {
        let buttons: [UIButton] = [firstOptionButton, secondOptionButton]

        guard let option = option else {
            buttons.forEach {
                $0.backgroundColor = .secondarySystemBackground
                $0.layer.borderWidth = 0.0
                $0.layer.borderColor = UIColor.clear.cgColor
            }
            return
        }
        
        let model = models[currentIndex]
        
        switch option {
        case .first:
            firstOptionButton.layer.borderColor = model.isCorrect ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
            firstOptionButton.layer.borderWidth = 1.0
            delegate?.optionSelected(status: model.isCorrect ? .success : .error)
        case .second:
            secondOptionButton.layer.borderColor = !model.isCorrect ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
            secondOptionButton.layer.borderWidth = 1.0
            delegate?.optionSelected(status: !model.isCorrect ? .success : .error)
        }
        
    }
    
    // MARK: - Actions
    @objc
    private func firstOptionDidTapped(_ sender: Any) {
        optionTapped(.first)
    }
    
    @objc
    private func secondOptionDidTapped(_ sender: Any) {
        optionTapped(.second)
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
        subviews(originalLabel, transcriptionLabel, translateLabel, firstDividerView, counterStackView, secondDividerView, allButtonsStackView)
        
        originalLabel.Top == safeAreaLayoutGuide.Top + 48
        originalLabel.centerHorizontally()
        
        transcriptionLabel.Top == originalLabel.Bottom + 16
        transcriptionLabel.centerHorizontally()
        
        translateLabel.Top == transcriptionLabel.Bottom + 12
        translateLabel.centerHorizontally()
        
        firstDividerView.Top == transcriptionLabel.Bottom + 48
        firstDividerView.fillHorizontally().height(1)
        
        counterStackView.Top == firstDividerView.Bottom + 16
        counterStackView.centerHorizontally()
        
        secondDividerView.Top == counterStackView.Bottom + 16
        secondDividerView.fillHorizontally().height(1)
        
        allButtonsStackView.Top == secondDividerView.Bottom + 48
        allButtonsStackView.fillHorizontally(padding: 16)
        
        firstOptionButton.height(70)
        secondOptionButton.height(70)
    }
}
