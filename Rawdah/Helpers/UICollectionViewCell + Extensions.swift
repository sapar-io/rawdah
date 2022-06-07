//
//  UICollectionViewCell + Extensions.swift
//  99Names
//
//  Created by Sapar Jumabekov on 27.05.2022.
//

import UIKit

extension UICollectionViewCell {
    /// Registering NIB with name of the Cell's class and reuseID with same name.
    /// For example: The reuse ID and Nib name of BoobCell would be "BoobCell".
    class func register(`for` collectionView: UICollectionView) {
        collectionView.register(self.nib, forCellWithReuseIdentifier: self.reuseID)
    }

    /// Регистрация класса ячейки без XIB
    class func registerWithoutNib(`for` collectionView: UICollectionView) {
        collectionView.register(self.self, forCellWithReuseIdentifier: self.reuseID)
    }

    /// Получние зарегистрированной ячейки
    class func dequeue(_ collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        return unsafeDowncast(collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseID, for: indexPath), to: self)
    }
}

extension UICollectionReusableView {
    /// Регистрация header/footer в collectionView
    class func registerWithoutNib(`for` collectionView: UICollectionView, forSupplementaryViewOfKind kind: String) {
        collectionView.register(self, forSupplementaryViewOfKind: kind, withReuseIdentifier: self.reuseID)
    }

    /// Получние зарегистрированной ячейки
    class func dequeue(_ collectionView: UICollectionView, ofKind kind: String, for indexPath: IndexPath) -> Self {
        return unsafeDowncast(collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.reuseID, for: indexPath), to: self)
    }

    /// Reuse ID that is the "class string name"
    class var reuseID: String {
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
