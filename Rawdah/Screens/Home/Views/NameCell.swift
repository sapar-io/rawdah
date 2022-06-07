//
//  NameCell.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import UIKit

class NameCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var transcriptionLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        numberLabel.textColor = .label
        originalLabel.textColor = .label
        transcriptionLabel.textColor = .label
        translateLabel.textColor = .label
    }
    
    // MARK: - Configure
    func configure(name: Name, isLearned: Bool) {
        selectionStyle = .none
        numberLabel.text = String(name.number)
        originalLabel.text = name.original
        transcriptionLabel.text = name.transcription
        translateLabel.text = name.translate
        
        numberLabel.textColor = isLearned ? .systemGreen : .label
        originalLabel.textColor = isLearned ? .systemGreen : .label
        transcriptionLabel.textColor = isLearned ? .systemGreen : .label
        translateLabel.textColor = isLearned ? .systemGreen : .label
    }
}
