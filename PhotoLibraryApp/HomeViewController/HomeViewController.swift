//
//  HomeViewController.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 02.11.2022.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class HomeViewController: UIViewController {
    private let searchBar = UISearchBar()
    private var photoCollectionView: UICollectionView!
    private var viewModel: HomeViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Пошук"
        searchBar.delegate = self
        
        configurePhotoCollectionView()
        
        viewModel.loadPhotos() { [unowned self] in
            photoCollectionView.reloadItems(at: photoCollectionView.indexPathsForVisibleItems)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoCollectionView.frame = view.bounds
    }

    private func configurePhotoCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        
        photoCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        photoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        
        view.addSubview(photoCollectionView)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.viewModel = viewModel.getPhotoCellViewModel(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.viewModel = viewModel.getDetailViewModel(at: indexPath)
        detailVC.title = "Details"
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetsFor section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

//MARK: - CHTCollectionViewDelegateWaterfallLayout
extension HomeViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.size.width / 2, height: CGFloat.random(in: 200...400))
    }
}

//MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        viewModel.searchPhotoByRequest(with: searchText) { [weak self] in
            self?.photoCollectionView.reloadData()
        }
    }
}

