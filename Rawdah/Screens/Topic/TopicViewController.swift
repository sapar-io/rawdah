//
//  TopicViewController.swift
//  99Names
//
//  Created by Sapar Jumabekov on 27.05.2022.
//

import UIKit
import Stevia

class TopicViewController: UIViewController {
    
    // MARK: - Variables
    private let index: (Int, Int)
    private let realm = RealmDB()
    private var isFinishAllNames = true
    private var isPassedQuiz: Bool
    
    // MARK: - Outlets
    private lazy var firstNameView: NameView = {
        let view = NameView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(firstDidTapped)))
        return view
    }()
    
    private lazy var secondNameView: NameView = {
        let view = NameView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(secondDidTapped)))
        return view
    }()
    
    private lazy var thirdNameView: NameView = {
        let view = NameView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(thirdDidTapped)))
        return view
    }()
    
    private lazy var forthNameView: NameView = {
        let view = NameView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forthDidTapped)))
        return view
    }()
    
    private lazy var fifthNameView: NameView = {
        let view = NameView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fifthDidTapped)))
        return view
    }()
    
    private lazy var sixNameView: NameView = {
        let view = NameView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sixDidTapped)))
        return view
    }()
    
    private lazy var sevenNameView: NameView = {
        let view = NameView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sevenDidTapped)))
        return view
    }()
    
    private lazy var eightNameView: NameView = {
        let view = NameView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(eightDidTapped)))
        return view
    }()
    
    private lazy var nineNameView: NameView = {
        let view = NameView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nineDidTapped)))
        return view
    }()
    
    private lazy var firstRowStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstNameView, secondNameView, thirdNameView])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var secondRowStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [forthNameView, fifthNameView, sixNameView])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var thirdRowStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sevenNameView, eightNameView, nineNameView])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstRowStackView, secondRowStackView, thirdRowStackView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let footerBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("topic_test_button".localized, for: [])
        button.setTitleColor(.white, for: [])
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(testDidTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold)
        return button
    }()
    
    private let closedView: TopicClosedView = {
        let view = TopicClosedView()
        view.isHidden = true
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupContent()
    }
    
    init(id: Int) {
        self.index = getTopicNumerationFromTo(id: id)
        self.isPassedQuiz = realm.isPassedQuiz(id: index.1 / 9)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setupContent() {
        isFinishAllNames = true
        testButton.backgroundColor = .systemGreen
        
        let nameViews = [firstNameView, secondNameView, thirdNameView, forthNameView, fifthNameView, sixNameView, sevenNameView, eightNameView, nineNameView]
        for i in 1...9 {
            let view = nameViews[i - 1]
            let index = index.0 + i - 1
            let name = AllNames[index - 1]
            let isFinish = realm.isLearnedName(id: name.number)
            view.configure(name: name, isFinish: isFinish)
            
            if !isFinish {
                isFinishAllNames = false
                testButton.backgroundColor = .gray
            }
        }
        
        if isPassedQuiz {
            testButton.setTitle("topic_test_passed_button".localized, for: [])
            testButton.setImage(UIImage(systemName: "checkmark"), for: [])
            testButton.isUserInteractionEnabled = false
            testButton.backgroundColor = .systemBackground
            testButton.setTitleColor(.systemGreen, for: [])
            testButton.tintColor = .systemGreen
            testButton.layer.borderWidth = 1.0
            testButton.layer.borderColor = UIColor.systemGreen.cgColor
            return
        }
        
        if index.0 != 1 {
            let previousIndex = (index.1 - 9) / 9
            
            if !realm.isPassedQuiz(id: previousIndex) {
                closedView.isHidden = false
            }
            
        }
    }
    
    private func openLesson(id: Int) {
        let name = AllNames[id - 1]
        let vc = LessonViewController(name: name)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showClosedAlert() {
        let alert = UIAlertController(title: "topic_test_close_title".localized,
                                      message: "topic_test_close_description".localized,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(.init(title: "topic_test_close_button".localized, style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @objc private func firstDidTapped() {
        openLesson(id: index.0)
    }
    
    @objc private func secondDidTapped() {
        openLesson(id: index.0 + 1)
    }
    
    @objc private func thirdDidTapped() {
        openLesson(id: index.0 + 2)
    }
    
    @objc private func forthDidTapped() {
        openLesson(id: index.0 + 3)
    }
    
    @objc private func fifthDidTapped() {
        openLesson(id: index.0 + 4)
    }
    
    @objc private func sixDidTapped() {
        openLesson(id: index.0 + 5)
    }
    
    @objc private func sevenDidTapped() {
        openLesson(id: index.0 + 6)
    }
    
    @objc private func eightDidTapped() {
        openLesson(id: index.0 + 7)
    }
    
    @objc private func nineDidTapped() {
        openLesson(id: index.0 + 8)
    }
    
    @objc private func testDidTapped() {
        guard isFinishAllNames else {
            showClosedAlert()
            return
        }
        
        let vc = TestViewController(index: index)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Setup
extension TopicViewController {
    private func setup() {
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "\(index.0)-\(index.1) \("topic_title".localized)"
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.subviews(footerBackgroundView)
        footerBackgroundView.bottom(0).fillHorizontally()
        
        view.subviews(testButton)
        testButton.fillHorizontally(padding: 8).height(56)
        testButton.Bottom == view.safeAreaLayoutGuide.Bottom - 24
        
        footerBackgroundView.Top == testButton.Top - 16
        
        view.subviews(mainStackView)
        mainStackView.fillHorizontally(padding: 8)
        mainStackView.Top == view.safeAreaLayoutGuide.Top + 8
        mainStackView.Bottom == footerBackgroundView.Top
        
        view.subviews(closedView)
        closedView.fillHorizontally().bottom(0)
        closedView.Top == view.safeAreaLayoutGuide.Top
    }
}
