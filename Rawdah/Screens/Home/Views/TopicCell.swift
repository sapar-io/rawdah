//
//  TopicCell.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import UIKit

class TopicCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var firstNameOriginalLabel: UILabel!
    @IBOutlet weak var firstNameTranscriptionLabel: UILabel!
    @IBOutlet weak var secondNameOriginalLabel: UILabel!
    @IBOutlet weak var secondNameTranscriptionLabel: UILabel!
    @IBOutlet weak var percentageView: UIView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var lockImageView: UIImageView!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        percentageView.layer.borderColor = UIColor.systemFill.cgColor
    }
    
    // MARK: - Configure
    func configure(id: Int, percentage: Int, isActive: Bool) {
        let index = getTopicNumerationFromTo(id: id)
        let firstName: Name = AllNames[index.0 - 1]
        let lastName: Name = AllNames[index.1 - 1]
        
        numberLabel.text = "\(index.0)-\(index.1)"
        firstNameOriginalLabel.text = firstName.original
        firstNameTranscriptionLabel.text = firstName.transcription
        secondNameOriginalLabel.text = lastName.original
        secondNameTranscriptionLabel.text = lastName.transcription
        percentageLabel.text = "\(percentage)%"
        
        if isActive {
            backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
            percentageView.layer.borderColor = UIColor.secondarySystemFill.cgColor
            lockImageView.isHidden = true
            percentageLabel.isHidden = false
        } else {
            backgroundColor = .clear
            percentageView.layer.borderColor = UIColor.systemFill.cgColor
            lockImageView.isHidden = percentage != 0
            percentageLabel.isHidden = percentage == 0
        }
        
        switch percentage {
        case 90:
            percentageLabel.textColor = .systemPurple
            percentageView.layer.borderColor = UIColor.systemPurple.cgColor
        case 100:
            percentageLabel.textColor = .systemGreen
            percentageView.layer.borderColor = UIColor.systemGreen.cgColor
        default:
            percentageLabel.textColor = .label
            percentageView.layer.borderColor = UIColor.systemFill.cgColor
        }
    }
}

// MARK: - Setup
extension TopicCell {
    private func setup() {
        selectionStyle = .none
        percentageView.layer.cornerRadius = 20
        percentageView.clipsToBounds = true
        percentageView.layer.borderWidth = 1.0
    }
}
