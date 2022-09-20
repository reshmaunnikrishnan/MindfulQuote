//
//  HTTPClient.swift
//  TopStories
//
//  Created by Reshma Unnikrishnan on 20.09.22.
//

import Foundation

protocol DataRequest {
    func sendRequest<T: Decodable>(endPoint: Endpoint, type: T.Type, completion: @escaping (Result<T, RequestError>) -> Void)
}

extension DataRequest {
    
    func sendRequest<T: Decodable>(endPoint: Endpoint, type: T.Type, completion: @escaping (Result<T, RequestError>) -> Void) {
        
        guard let url = endPoint.url else {
            fatalError()
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let decodedData = try jsonDecode(type.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(RequestError.decode))
                }
            }
        }
        
        task.resume()
    }
}


enum RequestError: Error, Equatable {
    case  invalidURL
    case noResponse
    case unknown
    case unauthorized
    case unexpectedStatusCode
    case decode
}
