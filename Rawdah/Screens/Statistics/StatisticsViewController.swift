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
    
    @IBOutlet weak var secondTextLabel: UILabel!
    
    @IBOutlet weak var thirdTextLabel: UILabel!
    
    @IBOutlet weak var supportLabel: UILabel!
    
    @IBOutlet weak var cardLabel: UILabel!
    
    @IBOutlet weak var copyCardButton: UIButton!
    
    @IBOutlet weak var copyNameButton: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func cardCopyButtonDidTapped(_ sender: Any) {
        UIPasteboard.general.string = "4400 4301 9500 9441"
        SPAlert.present(title: "Скопировано", preset: .done)
    }
    
    @IBAction func nameCopyButtonDidTapped(_ sender: Any) {
        UIPasteboard.general.string = "Sapar Jumabekov"
        SPAlert.present(title: "Скопировано", preset: .done)
    }
    
    // MARK: - Setup
    private func setup() {
        navigationItem.title = "tabs_interesting".localized
        
        firstTextLabel.text = "statistics_first_text".localized
        secondTextLabel.text = "statistics_second_text".localized
        thirdTextLabel.text = "statistics_third_text".localized
        supportLabel.text = "zikrs_button_text".localized
        cardLabel.text = "donation_card".localized
        copyCardButton.setTitle("donation_copy".localized, for: [])
        copyNameButton.setTitle("donation_copy".localized, for: [])
        
        mainStackView.layer.borderWidth = 1.0
        mainStackView.layer.borderColor = UIColor.systemGreen.cgColor
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 32, leading: 12, bottom: 32, trailing: 12)
        mainStackView.layer.cornerRadius = 24
        mainStackView.clipsToBounds = true
        
        copyCardButton.backgroundColor = .secondarySystemBackground
        copyCardButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        copyCardButton.clipsToBounds = true
        copyCardButton.layer.cornerRadius = 6
        
        copyNameButton.backgroundColor = .secondarySystemBackground
        copyNameButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        copyNameButton.clipsToBounds = true
        copyNameButton.layer.cornerRadius = 6
    }
}
