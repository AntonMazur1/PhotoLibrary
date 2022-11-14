//
//  DetailViewModel.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 03.11.2022.
//

import Foundation

protocol DetailViewModelProtocol {
    var photoUrl: String { get }
    var userLogoUrl: String { get }
    var userName: String { get }
    var numberOfLikes: String { get }
    var publishDate: String { get }
    init(photoUrl: String, userLogoUrl: String, userName: String, numberOfLikes: String, publishDate: String)
    func savePhoto()
    func deletePhoto()
    func isPhotoExist() -> Bool
}

class DetailViewModel: DetailViewModelProtocol {
    var photoUrl: String
    var userLogoUrl: String
    var userName: String
    var numberOfLikes: String
    var publishDate: String
    
    private var favouritePhoto: FavouritePhotos {
        FavouritePhotos(value: ["photoUrl": photoUrl,
                                "userLogoUrl": userLogoUrl,
                                "userName": userName,
                                "numberOfLikes": numberOfLikes,
                                "publishDate": publishDate])
    }
    
    required init(photoUrl: String,
                  userLogoUrl: String,
                  userName: String,
                  numberOfLikes: String,
                  publishDate: String) {
        self.photoUrl = photoUrl
        self.userLogoUrl = userLogoUrl
        self.userName = userName
        self.numberOfLikes = numberOfLikes
        self.publishDate = publishDate
    }
    
    func savePhoto() {
        StorageManager.shared.save(favouritePhoto)
    }
    
    func deletePhoto() {
        StorageManager.shared.delete(favouritePhoto)
    }
    
    func isPhotoExist() -> Bool {
        StorageManager.shared.isPhotoExist(favouritePhoto)
    }
}
