//
//  FavouritePhotosModel.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 05.11.2022.
//

import RealmSwift

class FavouritePhotos: Object {
    @Persisted var photoUrl: String = ""
    @Persisted var userLogoUrl: String = ""
    @Persisted var userName: String = ""
    @Persisted var numberOfLikes: String = ""
    @Persisted var publishDate: String = ""
}
