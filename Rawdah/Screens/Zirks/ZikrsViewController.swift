//
//  ZikrsViewController.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import UIKit
import StoreKit
import SPAlert

class ZikrsViewController: UIViewController {

    // MARK: - Variables
    
    // MARK: - Outlets
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var firstTextLabel: UILabel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        navigationItem.title = "tabs_zikrs".localized
        
        firstTextLabel.text = "zikrs_first_text".localized
        
        mainStackView.layer.borderWidth = 1.0
        mainStackView.layer.borderColor = UIColor.systemGreen.cgColor
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 32, leading: 12, bottom: 32, trailing: 12)
        mainStackView.layer.cornerRadius = 24
        mainStackView.clipsToBounds = true
    }
}
