//
//  PhotoCollectionViewCell.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 02.11.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "photoCell"
    
    private var photoImageView: UIImageView = {
        var photoImageView = UIImageView()
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 15
        return photoImageView
    }()
    
    var viewModel: PhotoCollectionCellViewModelProtocol! {
        didSet {
            photoImageView.loadImage(urlString: viewModel.photoUrl)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureImageView()
    }
    
    private func configureImageView() {
        contentView.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
