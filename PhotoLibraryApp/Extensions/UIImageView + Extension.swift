//
//  UIImageView + Extension.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 02.11.2022.
//

import UIKit

var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return}
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            if let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: NSString(string: urlString))
                
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
