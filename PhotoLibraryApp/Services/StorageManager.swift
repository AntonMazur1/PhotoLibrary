//
//  StorageManager.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 05.11.2022.
//

import Foundation
import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    private let realm = try! Realm()
    
    private init() {}
    
    func save(_ photo: FavouritePhotos) {
        write {
            realm.add(photo)
        }
    }
    
    func delete(_ photo: FavouritePhotos) {
        write {
            let photo = realm.objects(FavouritePhotos.self).where {
                $0.photoUrl == photo.photoUrl
            }
            realm.delete(photo)
        }
    }
    
    func receivePhotos() -> Results<FavouritePhotos> {
        let photo = try! realm.objects(FavouritePhotos.self)
        return photo
    }
    
    func isPhotoExist(_ photo: FavouritePhotos) -> Bool {
        realm.objects(FavouritePhotos.self).contains(where: { $0.photoUrl == photo.photoUrl })
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
}
