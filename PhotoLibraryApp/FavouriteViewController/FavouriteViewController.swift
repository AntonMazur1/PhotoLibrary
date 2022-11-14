//
//  FavouriteViewController.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 03.11.2022.
//

import UIKit

class FavouriteViewController: UIViewController {
    private var favouriteCollectionView: UICollectionView!
    var viewModel: FavouriteViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavouriteViewModel()
        title = "Favourite"
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.receiveFavouritePhoto() { [weak self] in
            self?.favouriteCollectionView.reloadData()
        }
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        favouriteCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        favouriteCollectionView.register(FavouriteCollectionViewCell.self, forCellWithReuseIdentifier: FavouriteCollectionViewCell.identifier)
        favouriteCollectionView.delegate = self
        favouriteCollectionView.dataSource = self
        
        view.addSubview(favouriteCollectionView)
    }
    
    private func showAlert(completion: @escaping () -> ()) {
        let alertController = UIAlertController(title: "Видалити", message: "Ви дійсно бажаєте видалити фото?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Нi", style: .cancel)
        let okAction = UIAlertAction(title: "Так", style: .default) { _ in
            completion()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.viewModel = viewModel.getDetailViewModel(at: indexPath)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favouriteCollectionView.dequeueReusableCell(withReuseIdentifier: FavouriteCollectionViewCell.identifier, for: indexPath) as! FavouriteCollectionViewCell
        cell.viewModel = viewModel.getFavouriteCellViewModel(at: indexPath)
        
        cell.deleteCell = { [weak self] in
            self?.showAlert {
                self?.favouriteCollectionView.deleteItems(at: [indexPath])
                self?.favouriteCollectionView.reloadItems(at: [indexPath])
            }
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FavouriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 10 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widhtPerItem = availableWidth / itemsPerRow
        return CGSize(width: widhtPerItem, height: widhtPerItem + widhtPerItem / 3)
    }
}
