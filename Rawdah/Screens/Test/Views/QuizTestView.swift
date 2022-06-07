//
//  QuizTestView.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 31.05.2022.
//

import Foundation
import UIKit
import Stevia

// MARK: - Models
private enum Option: Int {
    case first
    case second
    case third
    case forth
}

enum OptionStatus {
    case success
    case error
}

// MARK: - Delegate
protocol QuizTestDelegate: AnyObject {
    func optionSelected(status: OptionStatus)
}

// MARK: - Main
class QuizTestView: UIView {
    
    // MARK: - Variables
    private let index: (Int, Int)
    private let realm = RealmDB()
    private var names: [Name]
    private var currentIndex: Int = 0
    weak var delegate: QuizTestDelegate?
    
    var correctName: Name
    var correntNameIndex: Int = 0
    
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
        button.setTitle("First", for: [])
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
        button.setTitle("Second", for: [])
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
    
    private lazy var thirdOptionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Third", for: [])
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption2)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.label, for: [])
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(thirdOptionDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var forthOptionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Forth", for: [])
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption2)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.label, for: [])
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self, action: #selector(forthOptionDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var firstRowButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstOptionButton, secondOptionButton])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var secondRowButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thirdOptionButton, forthOptionButton])
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var allButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstRowButtonsStackView, secondRowButtonsStackView])
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Init
    init(index: (Int, Int)) {
        self.index = index
        var names = [Name]()
        for i in index.0 ... index.1 {
            names.append(AllNames[i - 1])
        }
        self.names = names.shuffled()
        self.correctName = names[currentIndex]
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
        
        let name = names[currentIndex]
        originalLabel.text = name.original
        transcriptionLabel.text = name.transcription
        
        setupAnswers()
    }
    
    func restart() {
        colorButton(nil)
        currentIndex = 0
        names = names.shuffled()
        setupTest(isInitial: true)
    }
    
    private func setupAnswers() {
        correctName = names[currentIndex]
        
        var otherNamesForAnswer = AllNames.filter { $0.original != correctName.original }.shuffled()[0...2]
        otherNamesForAnswer += [correctName]
        let shuffeledNames = otherNamesForAnswer.shuffled()
        
        for i in 0...3 {
            if shuffeledNames[i].number == correctName.number {
                correntNameIndex = i
            }
            
            switch i {
            case 0:
                firstOptionButton.setTitle(shuffeledNames[i].translate, for: [])
            case 1:
                secondOptionButton.setTitle(shuffeledNames[i].translate, for: [])
            case 2:
                thirdOptionButton.setTitle(shuffeledNames[i].translate, for: [])
            default:
                forthOptionButton.setTitle(shuffeledNames[i].translate, for: [])
            }
        }
    }
    
    private func optionTapped(_ option: Option) {
        colorButton(option)
    }
    
    private func colorButton(_ option: Option?) {
        let buttons: [UIButton] = [firstOptionButton, secondOptionButton, thirdOptionButton, forthOptionButton]

        guard let option = option else {
            buttons.forEach {
                $0.backgroundColor = .secondarySystemBackground
                $0.layer.borderWidth = 0.0
                $0.layer.borderColor = UIColor.clear.cgColor
            }
            return
        }
    
        switch option {
        case .first:
            firstOptionButton.layer.borderColor = correntNameIndex == 0 ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
            firstOptionButton.layer.borderWidth = 1.0
        case .second:
            secondOptionButton.layer.borderColor = correntNameIndex == 1 ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
            secondOptionButton.layer.borderWidth = 1.0
        case .third:
            thirdOptionButton.layer.borderColor = correntNameIndex == 2 ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
            thirdOptionButton.layer.borderWidth = 1.0
        case .forth:
            forthOptionButton.layer.borderColor = correntNameIndex == 3 ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
            forthOptionButton.layer.borderWidth = 1.0
        }
        
        delegate?.optionSelected(status: option.rawValue == correntNameIndex ? .success : .error)
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
    
    @objc
    private func thirdOptionDidTapped(_ sender: Any) {
        optionTapped(.third)
    }
    
    @objc
    private func forthOptionDidTapped(_ sender: Any) {
        optionTapped(.forth)
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
        subviews(originalLabel, transcriptionLabel, firstDividerView, counterStackView, secondDividerView, allButtonsStackView)
        
        originalLabel.Top == safeAreaLayoutGuide.Top + 32
        originalLabel.centerHorizontally()
        
        transcriptionLabel.Top == originalLabel.Bottom + 16
        transcriptionLabel.centerHorizontally()
        
        firstDividerView.Top == transcriptionLabel.Bottom + 24
        firstDividerView.fillHorizontally().height(1)
        
        counterStackView.Top == firstDividerView.Bottom + 16
        counterStackView.centerHorizontally()
        
        secondDividerView.Top == counterStackView.Bottom + 16
        secondDividerView.fillHorizontally().height(1)
        
        allButtonsStackView.Top == secondDividerView.Bottom + 24
        allButtonsStackView.fillHorizontally(padding: 16)
        
        firstOptionButton.height(100)
        secondOptionButton.height(100)
        thirdOptionButton.height(100)
        forthOptionButton.height(100)
    }
}
