//
//  Response.swift
//  snaphall
//
//  Created by IACD 013 on 2023/01/27.
//

import Foundation

struct Response: Codable {
    let total: Int
    let totalPages: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

struct Result: Codable {
    let id: String
    let createdAt: String
    let description: String?
    let altDescription: String
    let urls: Urls
    let likes: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case description
        case altDescription = "alt_description"
        case urls, likes
    }
}

struct Urls: Codable {
    let regular: String
}

enum Order {
    case latest, oldest, popular
}

