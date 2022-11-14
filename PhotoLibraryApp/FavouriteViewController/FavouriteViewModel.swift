//
//  FavouriteViewModel.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 03.11.2022.
//

import Foundation
import RealmSwift

protocol FavouriteViewModelProtocol {
    var numberOfItems: Int { get }
    func receiveFavouritePhoto(completion: () -> ())
    func getFavouriteCellViewModel(at indexPath: IndexPath) -> FavouriteCollectionViewCellViewModelProtocol?
    func getDetailViewModel(at indexPath: IndexPath) -> DetailViewModelProtocol?
}

class FavouriteViewModel: FavouriteViewModelProtocol {
    private var favouritePhotos: Results<FavouritePhotos>?
    
    var numberOfItems: Int {
        favouritePhotos?.count ?? 0
    }
    
    func receiveFavouritePhoto(completion: () -> ()) {
        favouritePhotos = StorageManager.shared.receivePhotos()
        completion()
    }
    
    func getFavouriteCellViewModel(at indexPath: IndexPath) -> FavouriteCollectionViewCellViewModelProtocol? {
        let favouritePhoto = favouritePhotos?[indexPath.row]
        return FavouriteCollectionViewCellViewModel(photoUrl: favouritePhoto?.photoUrl ?? "",
                                                    userLogoUrl: favouritePhoto?.userLogoUrl ?? "",
                                                    userName: favouritePhoto?.userName ?? "")
    }
    
    func getDetailViewModel(at indexPath: IndexPath) -> DetailViewModelProtocol? {
        let favouritePhoto = favouritePhotos?[indexPath.row]
        let photoUrl = favouritePhoto?.photoUrl ?? ""
        let userLogoUrl = favouritePhoto?.userLogoUrl ?? ""
        let userName = favouritePhoto?.userName ?? ""
        let numberOfLikes = favouritePhoto?.numberOfLikes ?? ""
        let publishDate = favouritePhoto?.publishDate ?? ""
        return DetailViewModel(photoUrl: photoUrl, userLogoUrl: userLogoUrl, userName: userName, numberOfLikes: numberOfLikes, publishDate: publishDate)
    }
}
