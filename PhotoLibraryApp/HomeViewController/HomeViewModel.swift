//
//  HomeViewModel.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 02.11.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    var numberOfItems: Int { get }
    func loadPhotos(completion: @escaping () -> ())
    func searchPhotoByRequest(with query: String, completion: @escaping () -> ())
    func getPhotoCellViewModel(at indexPath: IndexPath) -> PhotoCollectionCellViewModelProtocol?
    func getDetailViewModel(at indexPath: IndexPath) -> DetailViewModelProtocol?
}

class HomeViewModel: HomeViewModelProtocol {
    private var photos: [Model.PhotoElement] = []
    
    var numberOfItems: Int {
        photos.count
    }
    
    func loadPhotos(completion: @escaping () -> ()) {
        NetworkManager.loadPhotos { result in
            switch result {
            case .success(let photos):
                self.photos = photos
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func searchPhotoByRequest(with query: String, completion: @escaping () -> ()) {
        NetworkManager.searchPhotos(with: query) { result in
            switch result {
            case .success(let photos):
                self.photos = photos
                print("Success")
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getPhotoCellViewModel(at indexPath: IndexPath) -> PhotoCollectionCellViewModelProtocol? {
        guard let photo = photos[indexPath.row].urls?.small else { return nil }
        return PhotoCollectionCellViewModel(photoUrl: photo)
    }
    
    func getDetailViewModel(at indexPath: IndexPath) -> DetailViewModelProtocol? {
        guard let photoUrl = photos[indexPath.row].urls?.small else { return nil }
        let userLogoUrl = photos[indexPath.row].user?.profileImage?.small
        let userName = photos[indexPath.row].user?.name
        let numberOfLikes = photos[indexPath.row].likes?.description ?? "no likes"
        let publishDate = photos[indexPath.row].createdAt?.description ?? "no date"
        
        return DetailViewModel(photoUrl: photoUrl,
                               userLogoUrl: userLogoUrl ?? "",
                               userName: userName ?? "",
                               numberOfLikes: "\(numberOfLikes) likes",
                               publishDate: "Published: \(publishDate)"
        )
    }
}
