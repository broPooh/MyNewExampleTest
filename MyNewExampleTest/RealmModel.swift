//
//  RealmModel.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import Foundation
import RealmSwift

class GitItem: Object {
    @Persisted var id: Int
    @Persisted var title: String
    @Persisted var subtitle: String
    @Persisted var image: String
    @Persisted var actor: String
    @Persisted var userRating: String
    @Persisted var pubDate: String
    @Persisted var director: String
    @Persisted var link: String
    
    convenience init(id: Int, title: String, subtitle: String, image: String, actor: String, userRating: String, pubDate: String, director: String, link: String) {
        self.init()
        
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.actor = actor
        self.userRating = userRating
        self.pubDate = pubDate
        self.director = director
        self.link = link
    }
    
}
    
