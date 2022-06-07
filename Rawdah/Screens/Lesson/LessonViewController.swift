//
//  LessonViewController.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import UIKit
import Stevia
import AVFoundation

class LessonViewController: UIViewController {
    
    // MARK: - Variables
    private let name: Name
    private var player: AVAudioPlayer?
    private let realm = RealmDB()
    
    // MARK: - Lesson
    private let originalLabel: UILabel = {
        let label = UILabel()
        label.text = "original"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private let transcriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "transcription"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let translateLabel: UILabel = {
        let label = UILabel()
        label.text = "translate"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let buttonsBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .quaternarySystemFill
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
//    private lazy var resetButton: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "arrow.triangle.2.circlepath")
//        imageView.tintColor = .systemGreen
//        imageView.isUserInteractionEnabled = true
//        imageView.contentMode = .scaleAspectFit
//        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resetDidTapped)))
//        return imageView
//    }()
    
    private lazy var playerButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "play")
        imageView.tintColor = .systemGreen
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playerDidTapped)))
        return imageView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [playerButton])
        stackView.axis = .horizontal
        stackView.spacing = 24
        return stackView
    }()
    
    private let descriptionTopLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Описание".uppercased()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private lazy var learnButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выучить", for: [])
        button.setImage(UIImage(systemName: "checkmark"), for: [])
        button.setTitleColor(.systemGreen, for: [])
        button.tintColor = .systemGreen
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(learnedDidTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        originalLabel.text = name.original
        transcriptionLabel.text = name.transcription
        translateLabel.text = name.translate
        descriptionLabel.text = name.description
        
        if realm.isLearnedName(id: name.number) {
            changeButton()
        }
    }
    
    init(name: Name) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func playerDidTapped() {
        if player?.isPlaying == true {
            player?.pause()
            playerButton.image = UIImage(systemName: "play")
        } else {
            playMusic()
            playerButton.image = UIImage(systemName: "pause")
        }
    }
    
    @objc private func resetDidTapped() {
        player?.stop()
        playMusic()
        playerButton.image = UIImage(systemName: "play")
    }
    
    @objc private func learnedDidTapped() {
        realm.learnName(id: name.number, learned: true) { [unowned self] in
            changeButton()
        }
    }
    
    // MARK: - Private Methods
    private func playMusic() {
        guard let data = NSDataAsset(name: "name\(name.number)")?.data else {
            fatalError("Unable to find asset name12")
        }
        
        do {
            player = try AVAudioPlayer(data: data, fileTypeHint: AVFileType.mp3.rawValue)
            player?.numberOfLoops = -1
            player?.prepareToPlay()
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func changeButton() {
        learnButton.backgroundColor = .systemGreen
        learnButton.setTitleColor(.white, for: [])
        learnButton.tintColor = .white
        learnButton.setImage(UIImage(systemName: "checkmark.seal.fill"), for: [])
        learnButton.setTitle("Выучено", for: [])
        learnButton.isEnabled = false
    }
}

extension LessonViewController {
    private func setup() {
        navigationItem.title = "\(name.number). \(name.transcription)"
        view.backgroundColor = .systemBackground
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.subviews(originalLabel, transcriptionLabel, translateLabel, buttonsBackgroundView, descriptionTopLabel, descriptionLabel, learnButton)
        
        originalLabel.fillHorizontally(padding: 16)
        originalLabel.Top == view.safeAreaLayoutGuide.Top + 50
        
        transcriptionLabel.fillHorizontally(padding: 16)
        transcriptionLabel.Top == originalLabel.Bottom + 36
        
        translateLabel.fillHorizontally(padding: 16)
        translateLabel.Top == transcriptionLabel.Bottom + 12
        
        buttonsBackgroundView.fillHorizontally(padding: 16).height(72)
        buttonsBackgroundView.Top == translateLabel.Bottom + 48
        
        buttonsBackgroundView.subviews(buttonsStackView)
        
        buttonsStackView.centerInContainer()
        playerButton.size(40)
//        resetButton.size(40)
        
        learnButton.fillHorizontally(padding: 16).height(56)
        learnButton.Bottom == view.safeAreaLayoutGuide.Bottom - 16
        
        descriptionTopLabel.fillHorizontally(padding: 16)
        descriptionTopLabel.Top == buttonsBackgroundView.Bottom + 48
        
        descriptionLabel.fillHorizontally(padding: 16)
        descriptionLabel.Top == descriptionTopLabel.Bottom + 16
    }
}
