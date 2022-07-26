//
//  EndPoint.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case PUT
    case POST
    case DELETE
}

enum Endpoint {
    case searchBook
    case searchMovie
}

//https://openapi.naver.com/v1/search/movie.json?query=%EC%8A%A4%ED%8C%8C%EC%9D%B4%EB%8D%94%EB%A7%A8&display=15&start=1
extension Endpoint {
    var urlString: String {
        switch self {
        case .searchBook: return URL.makeEndPointString("v1/search/book.json")
        case .searchMovie: return URL.makeEndPointString("v1/search/movie.json")
        }
    }
}
