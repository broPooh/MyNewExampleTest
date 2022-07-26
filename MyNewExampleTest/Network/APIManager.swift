//
//  APIManager.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import Foundation

import Alamofire

import RxSwift
import RxCocoa
import RxAlamofire

final class APIManager {
    private init() { }
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    static let shared = APIManager()
    
    func searchMovie(query: String, start: Int) -> Observable<MovieResult> {
        let compoenet = APIManager.makeURLComponents(url: Endpoint.searchMovie.urlString, params: [
            "query": query
            //"start" : "\(start)"
        ])!
        print("쿼리2: \(query)")
        
        let request = APIManager.makeURLRequestFromComponent(component: compoenet, headers: [
            NetworkHeader.clientId.rawValue : NetworkHeaderField.clientId.field,
            NetworkHeader.clientSecret.rawValue : NetworkHeaderField.clientSecret.field,
        ])
               
        print("리퀘스트: \(request)")
        
//        return requestData(request)
//            .map { response, data -> MovieResult in
//                let decoder = JSONDecoder()
//                let data = try decoder.decode(MovieResult.self, from: data)
//                print("호출")
//                print(data)
//                return data
//            }
        
        return requestJSON(request)
            .map { $1 }
            .map { response -> MovieResult in
                print(response)
                let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let movieresult = try JSONDecoder().decode(MovieResult.self, from: data)
                return movieresult
            }
            
    }
    
    
    static func makeURLComponents(url: String, params: [String: String]) -> URLComponents? {
        guard var component = URLComponents(string: url) else { return nil}
        component.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        return component
    }
    
    static func makeURLRequestFromComponent(component: URLComponents, method: HTTPMethod = .GET, headers: [String : String]) -> URLRequest {
        var request = URLRequest(url: component.url!)
        request.httpMethod = method.rawValue
        
        headers.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
    
        return request
    }
}
