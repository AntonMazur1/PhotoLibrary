//
//  NetworkManager.swift
//  PhotoLibraryApp
//
//  Created by Клоун on 02.11.2022.
//

import Foundation

class NetworkManager {
    static func loadPhotos(completion: @escaping (Result<[Model.PhotoElement], Error>) -> Void) {
        let url = "https://api.unsplash.com/photos/?client_id=F9IJAa_idERwsPLG_Ed8-7xXs0FhhdIPmpogXwfTDpM"
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            do {
                guard let data = data else { return }
                let photos = try JSONDecoder().decode([Model.PhotoElement].self, from: data)
                completion(.success(photos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func searchPhotos(with query: String, completion: @escaping (Result<[Model.PhotoElement], Error>) -> Void) {
        let url = "https://api.unsplash.com/search/photos/?query=$\(query)&client_id=F9IJAa_idERwsPLG_Ed8-7xXs0FhhdIPmpogXwfTDpM"
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            do {
                guard let data = data else { return }
                let photos = try JSONDecoder().decode(Model.ToFind.self, from: data)
                completion(.success(photos.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
