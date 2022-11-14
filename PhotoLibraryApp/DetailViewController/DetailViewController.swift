//
//  DetailViewController.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 03.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    private var likeButton = UIButton()
    
    private var userNameLabel = UILabel(textColor: .black, font: .systemFont(ofSize: 18))
    private var numberOfLikesLabel = UILabel(textColor: .black, font: .boldSystemFont(ofSize: 16))
    private var publishDateLabel = UILabel(textColor: .lightGray, font: .boldSystemFont(ofSize: 14))
    
    private var personLogo = UIImageView(image: UIImage(systemName: "person.fill"))
    private var photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 30
        photoImageView.contentMode = .scaleAspectFill
        return photoImageView
    }()
    
    var viewModel: DetailViewModelProtocol! {
        didSet {
            photoImageView.loadImage(urlString: viewModel.photoUrl)
            personLogo.loadImage(urlString: viewModel.userLogoUrl)
            userNameLabel.text = viewModel.userName
            numberOfLikesLabel.text = viewModel.numberOfLikes
            publishDateLabel.text = viewModel.publishDate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        setupConstraints()
        addShareButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupImageForLikeButton()
    }
    
    private func setupConstraints() {
        let profileStackView = UIStackView(arrangedSubviews: [personLogo, userNameLabel, likeButton],
                                           direction: .horizontal,
                                           distribution: .fillProportionally,
                                           spacing: 10)
        
        let statStackView = UIStackView(arrangedSubviews: [numberOfLikesLabel, publishDateLabel],
                                        direction: .vertical,
                                        distribution: .fillProportionally,
                                        spacing: 10)
        
        let detailStackView = UIStackView(arrangedSubviews: [photoImageView, profileStackView, statStackView],
                                          direction: .vertical,
                                          distribution: .fill,
                                          spacing: 15)
        
        setupView(with: detailStackView)
        
        NSLayoutConstraint.activate([
            personLogo.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            detailStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            detailStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            detailStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupView(with views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupImageForLikeButton() {
        viewModel.isPhotoExist()
        ? likeButton.setImage(UIImage(named: "filledHeart"), for: .normal)
        : likeButton.setImage(UIImage(named: "favourite"), for: .normal)
    }
    
    private func addShareButton() {
        let shareButton = UIButton()
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
    }
    
    @objc private func likeButtonTapped() {
        guard likeButton.currentImage == UIImage(named: "favourite") else {
            viewModel.deletePhoto()
            likeButton.setImage(UIImage(named: "favourite"), for: .normal)
            
            return
        }
        
        viewModel.savePhoto()
        likeButton.setImage(UIImage(named: "filledHeart"), for: .normal)
    }
    
    @objc private func shareButtonTapped() {
        let shareSheetVC = UIActivityViewController(activityItems: [photoImageView.image],
                                                    applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
}
