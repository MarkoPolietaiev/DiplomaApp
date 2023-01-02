//
//  PostingModels.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2023-01-01.
//

import Foundation

struct Posting: Codable {
    var id: Int?
    var title: String
    var timeMinutes: Int
    var link: String
    var tags: [Tag]
    var steps: [Step]
    var description: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case timeMinutes = "time_minutes"
        case link = "link"
        case tags = "tags"
        case steps = "steps"
        case description = "description"
    }
}

struct Tag: Codable {
    var id: Int?
    var name: String
}

struct Step: Codable {
    var id: Int?
    var name: String
    var image: String
}
