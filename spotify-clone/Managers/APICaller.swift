//
//  APICaller.swift
//  spotify-clone
//
//  Created by Chandru A S on 04/12/24.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    private init() {}
    
    struct Constants {
        static let baseURL = "https://api.spotify.com/v1"
        
    }
    
    enum APIError: Error {
        case failToGetData
    }
    
    
    public func getAlbumDetails(for album: Album, completion: @escaping(Result<AlbumDetailsResponse, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURL + "/albums/\(album.id)"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                    completion(.success(result))
                    
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            
            task.resume()
        }
    }
    
    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping(Result<PlaylistDetailsResponse, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURL + "/playlists/\(playlist.id)"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                    
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            
            task.resume()
        }
    }
    
    
    public func getCurrentUserProfile(completion: @escaping(Result<UserProfile, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURL + "/me"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                    
                } catch {
                    completion(.failure(error))
                }
                
            }
            
            task.resume()
        }
    }
    
    
    public func getNewRelease(completion: @escaping((Result<NewReleasesResponse, Error>) -> Void)) {
        createRequest(
            with: URL(string: Constants.baseURL + "/browse/new-releases?limit=50"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
    
    public func getFeaturedPlaylists(completion: @escaping((Result<PlaylistResponse, Error>) -> Void)) {
        createRequest(
            with: URL(string: Constants.baseURL + "/me/playlists"), //"/browse/featured-playlists?limit=20"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response , error in
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code: \(httpResponse.statusCode)")
                }
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    
                    
                    let result = try JSONDecoder().decode(PlaylistResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendations(genres: Set<String>,  completion: @escaping ((Result<RecommendationResponse, Error>) -> Void)) {
        let seeds = genres.joined(separator: ",")
        createRequest(
            with: URL(string: Constants.baseURL + "/recommendations?limit=40&seed_genres=\(seeds)"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _ , error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendationResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func getRecommendedGeners(completion: @escaping ((Result<RecommendedGenresResponse, Error>)) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURL + "/recommendations/available-genre-seeds"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code: \(httpResponse.statusCode)")
                }
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCategories(completion: @escaping ((Result<[Category], Error>)) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURL + "/browse/categories?limit=50"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code: \(httpResponse.statusCode)")
                }
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                    completion(.success(result.categories.items))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCategoriesPlaylists(category: Category, completion: @escaping ((Result<[Playlist], Error>)) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURL + "/browse/categories/\(category.id)/playlists"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code: \(httpResponse.statusCode)")
                }
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    
                    
//                    let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                    print(response)
                    
                    
                    let result = try JSONDecoder().decode(CategoriesPlaylistsResponse.self, from: data)
                    completion(.success(result.playlists.items))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func search(with query: String, completion: @escaping (Result<[SearchResult], Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseURL + "/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code: \(httpResponse.statusCode)")
                }
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    
                    
//                    let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                    print(response)
                    
                    
                    let result = try JSONDecoder().decode(SearchResultsResponse.self, from: data)
                    
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf:  result.tracks.items.compactMap({ .tracks(model: $0) }))
                    searchResults.append(contentsOf:  result.albums.items.compactMap({ .albums(model: $0) }))
//                    searchResults.append(contentsOf:  result.playlists.items.compactMap({ .playlists(model: $0) }))
                    searchResults.append(contentsOf:  result.artists.items.compactMap({ .artists(model: $0) }))
                    
                    completion(.success(searchResults))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    
    
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?,type: HTTPMethod, completion: @escaping(URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let url = url else {
                return
            }
            
            var request = URLRequest(url: url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
            
        }
    }
}
