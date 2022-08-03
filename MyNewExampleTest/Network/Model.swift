//
//  Model.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/25.
//

import Foundation

// MARK: - MovieResult
struct MovieResult: Codable {
    let lastBuildDate: String?
    let start: Int?
    let total: Int?
    var items: [Movie] = []
    let display: Int?
}

// MARK: - Item
struct Movie: Codable {
    let subtitle: String?
    let image: String?
    let title: String?
    let actor: String?
    let userRating: String?
    let pubDate: String?
    let director: String?
    let link: String?
    var favorite: Bool? = false
    
    init(subtitle: String?, image: String?, title: String?, actor: String?, userRating: String?, pubDate: String?, director: String?, link: String?, favorite: Bool = false)  {
        self.subtitle = subtitle
        self.image = image
        self.title = title
        self.actor = actor
        self.userRating = userRating
        self.pubDate = pubDate
        self.director = director
        self.link = link
        self.favorite = favorite
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        subtitle = try values.decodeIfPresent(String.self, forKey: .subtitle)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        actor = try values.decodeIfPresent(String.self, forKey: .actor)
        userRating = try values.decodeIfPresent(String.self, forKey: .userRating)
        pubDate = try values.decodeIfPresent(String.self, forKey: .pubDate)
        director = try values.decodeIfPresent(String.self, forKey: .director)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        favorite = (try? values.decode(Bool.self, forKey: .favorite)) ?? false
    }
    
    private enum CodingKeys: String, CodingKey {
        case subtitle
        case image
        case title
        case actor
        case userRating
        case pubDate
        case director
        case link
        case favorite
    }
}
