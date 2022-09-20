//
//  HTTPClient.swift
//  TopStories
//
//  Created by Reshma Unnikrishnan on 20.09.22.
//

import Foundation

protocol DataRequestProtocol {
    func sendRequest<T: Decodable>(endPoint: Endpoint, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class DataRequest: DataRequestProtocol {
    
    func sendRequest<T: Decodable>(endPoint: Endpoint, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
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
                    completion(.failure(error))
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
