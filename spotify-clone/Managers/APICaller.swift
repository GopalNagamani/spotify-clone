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
        case failToGetDate
    }
    
    
    public func getCurrentUserProfile(completion: @escaping(Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseURL + "/me"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetDate))
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
        createRequest(with: URL(string: Constants.baseURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, _ , error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetDate))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    print(result)
                    completion(.success(result))
                } catch {
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
