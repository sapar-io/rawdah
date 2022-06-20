//
//  DonateCell.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 17.06.2022.
//

import UIKit

class DonateCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var donateTitleLabel: UILabel!
    @IBOutlet weak var donateDescriptionLabel: UILabel!
    @IBOutlet weak var donateButton: UIButton!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func donateButtonDidTapped(_ sender: Any) {
        let url = URL(string: "https://www.buymeacoffee.com/sapar")
        guard let url = url, UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - Setups
    private func setup() {
        donateTitleLabel.text = "donate_title".localized
        donateTitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        
        donateDescriptionLabel.text = "donate_description".localized
        donateDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        donateButton.setTitle("donate_button".localized.uppercased(), for: [])
        donateButton.backgroundColor = .systemGreen
        donateButton.setTitleColor(.white, for: [])
        donateButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .semibold)
        donateButton.clipsToBounds = true
        donateButton.layer.cornerRadius = 6    }
}
