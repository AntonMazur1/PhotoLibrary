//
//  UIStackView + Extension.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 03.11.2022.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], direction: NSLayoutConstraint.Axis, distribution: Distribution = .fill, spacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = direction
        self.spacing = spacing
        self.distribution = distribution
    }
}
