//
//  UILabel + Extension.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 03.11.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String = "", textColor: UIColor, font: UIFont) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
    }
}
