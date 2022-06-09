//
//  InitialViewController.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 07.06.2022.
//

import UIKit
import Stevia

class InitialViewController: UIViewController {
    
    // MARK: - Outlets
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let sponsorLabel: UILabel = {
        let label = UILabel()
        label.text = "Powered by"
        label.textColor = .secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let sponserImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sponser")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var sponserStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sponsorLabel, sponserImageView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.pushViewController(TabBarController(), animated: true)
    }
    
    // MARK: - Setups
    private func setup() {
        view.backgroundColor = .systemBackground
        
        view.subviews(logoImageView, sponserStackView)
        logoImageView.width(60%).heightEqualsWidth().centerInContainer()
        
        sponserStackView.Bottom == view.safeAreaLayoutGuide.Bottom - 16
        sponserStackView.centerHorizontally()
        sponserImageView.height(100).width(150)
    }
}
