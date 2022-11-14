//
//  PhotoCollectionCellViewModel.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 02.11.2022.
//

import Foundation

protocol PhotoCollectionCellViewModelProtocol {
    var photoUrl: String { get }
}

class PhotoCollectionCellViewModel: PhotoCollectionCellViewModelProtocol {
    var photoUrl: String
    
    init(photoUrl: String) {
        self.photoUrl = photoUrl
    }
}
