//
//  UIImageView + Extension.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 03.11.2022.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage, cornerRadius: CGFloat) {
        self.init()
        self.image = image
        self.layer.cornerRadius = cornerRadius
    }
}
