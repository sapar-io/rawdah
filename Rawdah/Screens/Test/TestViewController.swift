//
//  TestViewController.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import UIKit
import Stevia
import SPConfetti

class TestViewController: UIViewController {
    
    // MARK: - Models
    private enum TestType {
        case quiz
        case trueFalse
    }
    
    // MARK: - Variables
    private let realm = RealmDB()
    private let index: (Int, Int)
    private var testNumber: Int = 0
    private var type: TestType = .quiz
    private var successCounter: Int = 0
    private var errorCounter: Int = 0
    
    // MARK: - Outlets
    private let progressView = QuizProgressView()
    
    private let quizView: QuizTestView
    
    private let trueFalseTestView: TrueFalseTestView
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: [])
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("Следующий вопрос", for: [])
        button.isHidden = true
        button.addTarget(self, action: #selector(nextDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var successView: SuccessTestAlertView = {
        let view = SuccessTestAlertView(index: index)
        view.isHidden = true
        view.delegate = self
        return view
    }()
    
    private lazy var errorView: ErrorTestAlertView = {
        let view = ErrorTestAlertView(index: index)
        view.isHidden = true
        view.delegate = self
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    init(index: (Int, Int)) {
        self.index = index
        self.quizView = QuizTestView(index: index)
        self.trueFalseTestView = TrueFalseTestView(index: index)
        super.init(nibName: nil, bundle: nil)
        quizView.delegate = self
        trueFalseTestView.delegate = self
        trueFalseTestView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc
    private func nextDidTapped(_ sender: Any) {
        nextButton.isHidden = true
        quizView.isUserInteractionEnabled = true
        trueFalseTestView.isUserInteractionEnabled = true
        setupTest()
    }
    
    // MARK: - Private Methods
    private func setupTest() {
        testNumber += 1
        
        progressView.questionNumber = testNumber
        
        if testNumber == 9 {
            quizView.isHidden = true
            trueFalseTestView.isHidden = false
            type = .trueFalse
            return
        }
        
        switch type {
        case .quiz:
            quizView.setupTest()
        case .trueFalse:
            trueFalseTestView.setupTest()
        }
    }
    
    private func showResult() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        progressView.isHidden = true
        trueFalseTestView.isHidden = true
        quizView.isHidden = true
        
        if errorCounter > 0 {
            errorView.isHidden = false
            errorView.successLabel.text = "Правильных ответов: \(successCounter)"
            errorView.errorLabel.text = "Неправильных ответов: \(errorCounter)"
        } else {
            SPConfetti.startAnimating(.centerWidthToDown, particles: [.triangle, .arc, .circle, .polygon], duration: 5)
            successView.isHidden = false
            realm.passQuiz(id: index.1 / 9, passed: true) {
                print("passQuiz")
            }
        }
    }
    
    // MARK: - Setup
    private func setup() {
        navigationItem.title = "Тест по имёнам \(index.0) - \(index.1)"
        view.backgroundColor = .systemBackground
        
        view.subviews(progressView, quizView, trueFalseTestView, nextButton, successView, errorView)
        
        progressView.fillHorizontally().height(30)
        progressView.Top == view.safeAreaLayoutGuide.Top
        
        nextButton.fillHorizontally(padding: 16).height(56)
        nextButton.Bottom == view.safeAreaLayoutGuide.Bottom - 16
        
        quizView.Top == progressView.Bottom
        quizView.fillHorizontally()
        quizView.Bottom == nextButton.Top
        
        trueFalseTestView.Top == progressView.Bottom
        trueFalseTestView.fillHorizontally()
        trueFalseTestView.Bottom == nextButton.Top
        
        successView.Top == view.safeAreaLayoutGuide.Top
        successView.fillContainer()
        successView.Bottom == view.safeAreaLayoutGuide.Bottom
        
        errorView.Top == view.safeAreaLayoutGuide.Top
        errorView.fillContainer()
        errorView.Bottom == view.safeAreaLayoutGuide.Bottom
    }
}

// MARK: - Quiz Delegate
extension TestViewController: QuizTestDelegate, TrueFalseTestDelegate {
    func optionSelected(status: OptionStatus) {
        switch status {
        case .success:
            successCounter += 1
            quizView.successCounterLabel.text = String(successCounter)
            trueFalseTestView.successCounterLabel.text = String(successCounter)
        case .error:
            errorCounter += 1
            quizView.errorCounterLabel.text = String(errorCounter)
            trueFalseTestView.errorCounterLabel.text = String(errorCounter)
        }
        
        if testNumber == 26 {
            showResult()
            return
        }
        
        quizView.isUserInteractionEnabled = false
        trueFalseTestView.isUserInteractionEnabled = false
        nextButton.isHidden = false
    }
}

// MARK: - Success Alert
extension TestViewController: SuccessTestAlertViewDelegate {
    func nextTapped() {
        navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    func shareTapped() {
        print("share")
    }
}

// MARK: - Error Alert
extension TestViewController: ErrorTestAlertViewDelegate {
    func closeTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func restartTapped() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        progressView.isHidden = false
        quizView.isHidden = false
        trueFalseTestView.isHidden = true
        
        errorView.isHidden = true
        successView.isHidden = true
        
        progressView.questionNumber = 0
        type = .quiz
        testNumber = 0
        successCounter = 0
        errorCounter = 0
        
        quizView.successCounterLabel.text = String(0)
        trueFalseTestView.successCounterLabel.text = String(0)
        quizView.errorCounterLabel.text = String(0)
        trueFalseTestView.errorCounterLabel.text = String(0)
        
        quizView.restart()
        trueFalseTestView.restart()
    }
}
