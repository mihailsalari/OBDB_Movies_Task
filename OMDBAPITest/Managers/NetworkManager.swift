//
//  NetworkManager.swift
//  OMDBAPITest
//
//  Created by Mihail Salari on 7/14/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case emptyData
    case invalidResponse
    case httpError(statusCode: Int)
    case imageDownloadFailed
}

protocol NetworkManagerProtocol: AnyObject {
    func request<T: Decodable>(with urlString: String, method: HTTPMethod, parameters: [String: Any]?, headers: [String: String]?,
                 completion: @escaping (Result<T, Error>) -> Void)
    
    func downloadImage(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(with urlString: String, method: HTTPMethod, parameters: [String: Any]?, headers: [String: String]?,
                 completion: @escaping (Result<T, Error>) -> Void) {
        
        guard var urlComponents = URLComponents(string: urlString) else {
              return completion(.failure(NetworkError.invalidURL))
          }
          
          // Set query parameters
          if let parameters = parameters {
              urlComponents.queryItems = parameters.map { key, value in
                  URLQueryItem(name: key, value: "\(value)")
              }
          }
          
          guard let url = urlComponents.url else {
              return completion(.failure(NetworkError.invalidURL))
          }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        // TODO: - In case we need to modify the method, leave, if not, delete
//        if let parameters = parameters {
//            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
//        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return completion(.failure(NetworkError.requestFailed(error)))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                 return completion(.failure(NetworkError.invalidResponse))
             }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let httpError = NetworkError.httpError(statusCode: httpResponse.statusCode)
                return completion(.failure(httpError))
            }
            
            guard let data = data else {
                return completion(.failure(NetworkError.emptyData))
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(NetworkError.invalidURL))
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                return completion(.failure(NetworkError.requestFailed(error)))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.invalidResponse))
            }
            
            guard httpResponse.statusCode == 200 else {
                let httpError = NetworkError.httpError(statusCode: httpResponse.statusCode)
                return completion(.failure(httpError))
            }
            
            guard let data = data else {
                return completion(.failure(NetworkError.imageDownloadFailed))
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
