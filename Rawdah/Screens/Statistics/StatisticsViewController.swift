//
//  StatisticsViewController.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import UIKit
import StoreKit
import SPAlert

class StatisticsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var firstTextLabel: UILabel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func cardCopyButtonDidTapped(_ sender: Any) {
        let url = URL(string: "https://www.buymeacoffee.com/sapar")
        guard let url = url, UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - Setup
    private func setup() {
        navigationItem.title = "tabs_interesting".localized
        firstTextLabel.text = "statistics_first_text".localized
        
        mainStackView.layer.borderWidth = 1.0
        mainStackView.layer.borderColor = UIColor.systemGreen.cgColor
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 32, leading: 12, bottom: 32, trailing: 12)
        mainStackView.layer.cornerRadius = 24
        mainStackView.clipsToBounds = true
    }
}
