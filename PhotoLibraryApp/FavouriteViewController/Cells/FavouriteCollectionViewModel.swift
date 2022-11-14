//
//  FavouriteCollectionViewModel.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 03.11.2022.
//

import Foundation

protocol FavouriteCollectionViewCellViewModelProtocol {
    var photoUrl: String { get }
    var userLogoUrl: String { get }
    var userName: String { get }
    init(photoUrl: String, userLogoUrl: String, userName: String)
    func deletePhoto(completion: () -> ())
}

class FavouriteCollectionViewCellViewModel: FavouriteCollectionViewCellViewModelProtocol {
    private var favouritePhoto: FavouritePhotos {
        FavouritePhotos(value: ["photoUrl": photoUrl,
                                "userLogoUrl": userLogoUrl,
                                "userName": userName])
    }
    var photoUrl: String
    var userLogoUrl: String
    var userName: String
    
    required init(photoUrl: String, userLogoUrl: String, userName: String) {
        self.photoUrl = photoUrl
        self.userLogoUrl = userLogoUrl
        self.userName = userName
    }
    
    func deletePhoto(completion: () -> ()) {
        StorageManager.shared.delete(favouritePhoto)
        completion()
    }
}
