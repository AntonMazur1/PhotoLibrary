//
//  PhotoViewModel.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 02.11.2022.
//

import Foundation

enum Model {
    
}

extension Model {
    struct ToFind: Codable {
        let total: Int
        let total_pages: Int
        let results: [PhotoElement]
    }
    
    struct PhotoElement: Codable {
        let id: String
        let createdAt: String?
        let height: Int?
        let photoDescription: String?
        let urls: Urls?
        let likes: Int?
        let user: User?
    }

    struct User: Codable {
        let id: String?
        let username, name, firstName: String?
        let profileImage: ProfileImage?
    }

    struct ProfileImage: Codable {
        let small: String?
    }

    struct Urls: Codable {
        let small: String?
    }
}
