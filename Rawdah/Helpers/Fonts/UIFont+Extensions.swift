//
//  UIFont+Extensions.swift
//  Rawdah
//
//  Created by Sapar Jumabekov on 07.06.2022.
//

import UIKit

extension UIFont {
    func with(weight: UIFont.Weight) -> UIFont {
        return UIFont.systemFont(ofSize: pointSize, weight: weight)
    }
}

public extension UIFont {
    
    /**
     SparrowKit: Convert font to rounded design.
     */
    var rounded: UIFont {
        if #available(iOS 13, tvOS 13, *) {
            guard let descriptor = fontDescriptor.withDesign(.rounded) else { return self }
            return UIFont(descriptor: descriptor, size: 0)
        } else {
            return self
        }
        
    }
    
    /**
     SparrowKit: Convert font to monospaced design.
     */
    var monospaced: UIFont {
        if #available(iOS 13, tvOS 13, *) {
            guard let descriptor = fontDescriptor.withDesign(.monospaced) else { return self }
            return UIFont(descriptor: descriptor, size: 0)
        } else {
            return self
        }
    }
    
    /**
     SparrowKit: Convert font to serif design.
     */
    var serif: UIFont {
        if #available(iOS 13, tvOS 13, *) {
            guard let descriptor = fontDescriptor.withDesign(.serif) else { return self }
            return UIFont(descriptor: descriptor, size: 0)
        } else {
            return self
        }
    }
    
    /**
     SparrowKit: Get font by text style and correction.
     
     If you not apply correction, you get system size of font.
     
     - parameter style: Text style for which need font size.
     - parameter addPoints: Correction of size font.
     */
    static func preferredFont(forTextStyle style: TextStyle, addPoints: CGFloat = 0) -> UIFont {
        let referensFont = UIFont.preferredFont(forTextStyle: style)
        return referensFont.withSize(referensFont.pointSize + addPoints)
    }
    
    /**
     SparrowKit: Get font by text style and correction. With custom font weight.
     
     If you not apply correction, you get system size of font.
     
     - parameter style: Text style for which need font size.
     - parameter weight: Custom weight of font.
     - parameter addPoints: Correction of size font.
     */
    static func preferredFont(forTextStyle style: TextStyle, weight: Weight, addPoints: CGFloat = 0) -> UIFont {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: descriptor.pointSize + addPoints, weight: weight)
        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: font)
    }
}
