//
//  SettingsCell.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import UIKit
import Stevia

final class SettingsCell: UITableViewCell {
    
    // MARK: - Views
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    
    // MARK: - Internal
    internal func configure(with model: SettingsOption) {
        label.text = model.title
        iconImageView.image = model.icon
    }
}

// MARK: - Layout
extension SettingsCell {
    private func setupConstraints() {
        contentView.subviews(iconImageView, label)
        iconImageView.size(24).centerVertically().left(20)
        label.Left == iconImageView.Right + 10
        label.centerVertically().right(15)
    }
}
