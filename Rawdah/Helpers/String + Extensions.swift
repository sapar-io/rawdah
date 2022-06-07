//
//  String + Extensions.swift
//  99Names
//
//  Created by Sapar Jumabekov on 28.05.2022.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
