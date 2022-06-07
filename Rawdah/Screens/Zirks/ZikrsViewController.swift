//
//  ZikrsViewController.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import UIKit

class ZikrsViewController: UIViewController {

    // MARK: - Variables
    
    // MARK: - Outlets
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var firstTextLabel: UILabel!
    
    @IBOutlet weak var secondTextLabel: UILabel!
    
    @IBOutlet weak var thirdTextLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @IBAction func donationButtonDidTapped(_ sender: Any) {
        let alert = UIAlertController(title: "donation_title".localized, message: "donation_description".localized, preferredStyle: .actionSheet)
        
        IAPManager.shared.products.forEach {
            guard let product = IAPManager.Product(rawValue: $0.productIdentifier) else {
                return
            }
            
            let currencyCode = $0.priceLocale.currencyCode
            
            alert.addAction(UIAlertAction(title: "\($0.price) \(currencyCode ?? "")", style: .default, handler: { (_) in
                IAPManager.shared.purchase(product: product) {
                    print("complete")
                }
            }))
        }
        
        alert.addAction(.init(title: "donation_cancel".localized, style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - Setup
extension ZikrsViewController {
    private func setup() {
        navigationItem.title = "tabs_zikrs".localized
        
        firstTextLabel.text = "zikrs_first_text".localized
        secondTextLabel.text = "zikrs_second_text".localized
        thirdTextLabel.text = "zikrs_third_text".localized
        button.setTitle("zikrs_button_text".localized, for: [])
        
        mainStackView.layer.borderWidth = 1.0
        mainStackView.layer.borderColor = UIColor.systemGreen.cgColor
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32)
        mainStackView.layer.cornerRadius = 24
        mainStackView.clipsToBounds = true
        
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold)
    }
}
