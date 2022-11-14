//
//  FavouriteCollectionViewCell.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 03.11.2022.
//

import UIKit

class FavouriteCollectionViewCell: UICollectionViewCell {
    static let identifier = "detailCell"
    
    private var photoImageView: UIImageView = {
        var photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 15
        return photoImageView
    }()
    
    private var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 20
        return logoImageView
    }()
    
    private var unlikeButton: UIButton = {
        let unlikeButton = UIButton()
        unlikeButton.setImage(UIImage(named: "filledHeart"), for: .normal)
        return unlikeButton
    }()
    
    private var userNameLabel = UILabel(textColor: .black, font: .systemFont(ofSize: 13))
    
    var deleteCell: (() -> Void)?
    
    var viewModel: FavouriteCollectionViewCellViewModelProtocol! {
        didSet {
            photoImageView.loadImage(urlString: viewModel.photoUrl)
            logoImageView.loadImage(urlString: viewModel.userLogoUrl)
            userNameLabel.text = viewModel?.userName
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        unlikeButton.addTarget(self, action: #selector(unlikeButtonTapped), for: .touchUpInside)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        unlikeButton.addTarget(self, action: #selector(unlikeButtonTapped), for: .touchUpInside)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let userStatsStackView = UIStackView(arrangedSubviews: [logoImageView, userNameLabel, unlikeButton],
                                             direction: .horizontal,
                                             distribution: .fillProportionally,
                                             spacing: 5)
        setupViews(photoImageView, userStatsStackView)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            
            userStatsStackView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            userStatsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            userStatsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            userStatsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5)
        ])
    }
    
    private func setupViews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    @objc func unlikeButtonTapped() {
        viewModel.deletePhoto {
            deleteCell?()
        }
    }
}
