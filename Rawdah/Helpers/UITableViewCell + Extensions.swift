//
//  UITableViewCell + Extensions.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import UIKit

extension UITableViewCell {
    /// Registering NIB with name of the Cell's class and reuseID with same name.
    /// For example: The reuse ID and Nib name of BoobCell would be "BoobCell".
    class func register(`for` tableView: UITableView) {
        tableView.register(self.nib, forCellReuseIdentifier: self.reuseID)
    }

    class func registerWithoutNib(`for` tableView: UITableView) {
        tableView.register(self.self, forCellReuseIdentifier: self.reuseID)
    }

    class func dequeue(_ tableView: UITableView, for indexPath: IndexPath) -> Self {
        return unsafeDowncast(tableView.dequeueReusableCell(withIdentifier: self.reuseID, for: indexPath), to: self)
    }

    /// Reuse ID that is the "class string name"
    fileprivate class var reuseID: String {
        return stringName
    }

    /// Xib for this class
    fileprivate class var nib: UINib {
        return UINib(nibName: stringName, bundle: nil)
    }

    fileprivate class var stringName: String {
        return String(describing: self.self)
    }
}

// MARK: - Separator visibility

extension UITableViewCell {
    enum SeparatorVisibilityStyle {
        case none
        case `default`(leftInset: CGFloat = 16)
    }

    func fc_updateSeparatorVisibilityStyle(_ separatorVisibilityStyle: SeparatorVisibilityStyle) {
        switch separatorVisibilityStyle {
        case .none:
            separatorInset = UIEdgeInsets.init(top: 0, left: -.greatestFiniteMagnitude, bottom: 0, right: 0)
        case .default(let leftInset):
            separatorInset = UIEdgeInsets.init(top: 0, left: leftInset, bottom: 0, right: 0)
        }
    }
}
