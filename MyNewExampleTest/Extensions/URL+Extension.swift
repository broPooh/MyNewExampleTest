//
//  URL+Extension.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import Foundation

extension URL {
    
    static let baseURL = "https://openapi.naver.com/"
    //https://openapi.naver.com/v1/search/movie.json?query=%EC%8A%A4%ED%8C%8C%EC%9D%B4%EB%8D%94%EB%A7%A8&display=15&start=1

    static func makeEndPointString(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}

