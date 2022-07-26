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
    let items: [Movie]?
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
}
