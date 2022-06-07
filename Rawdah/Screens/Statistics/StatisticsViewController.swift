//
//  StatisticsViewController.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import UIKit

class StatisticsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var button: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Actions
    @IBAction func donationButtonDidTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Поддержать проект", message: "Выберите сумму", preferredStyle: .actionSheet)
        
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
        
        alert.addAction(.init(title: "Отменить", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - Setup
extension StatisticsViewController {
    private func setup() {
        navigationItem.title = "Интересное"
        
        mainStackView.layer.borderWidth = 1.0
        mainStackView.layer.borderColor = UIColor.systemGreen.cgColor
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32)
        mainStackView.layer.cornerRadius = 24
        mainStackView.clipsToBounds = true
        
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
    }
}
