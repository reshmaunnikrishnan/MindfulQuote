//
//  Datawrapper.swift
//  MindfulQuote
//
//  Created by Reshma Unnikrishnan on 20.09.22.
//

import Foundation

public struct DataWrapper<T: Decodable>: Decodable {

    enum CodingKeys: String, CodingKey {
        case data = "data"
    }

    public let data: T
}


/// Global JSON decoder used throughout the app
private let jsonDecoder: JSONDecoder = {
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}()

func jsonDecode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {

    do {
        // First try to decode data-wrapped JSON
        return try jsonDecoder.decode(DataWrapper<T>.self, from: data).data
    } catch let DecodingError.keyNotFound(codingKey, context)
                where (codingKey as? DataWrapper<T>.CodingKeys == .data && context.codingPath.isEmpty) {
        // If `data` key wasn't found on root level: Decode model object directly
        return try jsonDecoder.decode(T.self, from: data)
    } catch {
        // If any other error occurs: Throw it, so we can see the correct coding key in the debug alert
        throw error
    }
}
