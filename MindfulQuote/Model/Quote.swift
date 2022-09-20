//
//  Quote.swift
//  MindfulQuotes
//
//  Created by Reshma Unnikrishnan on 17.09.22.
//

import Foundation

struct Quote: Codable {
    let createdAt: String
    let id: String
    let lang: String
    let text: String
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, text, lang
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
