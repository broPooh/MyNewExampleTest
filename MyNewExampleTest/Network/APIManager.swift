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
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    private init() {
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    static let shared = APIManager()
    
    func searchMovie(query: String, start: Int) -> Observable<MovieResult> {
        let compoenet = makeURLComponents(url: Endpoint.searchMovie.urlString, params: [
            "query": query,
            "start" : "\(start)"
        ])!
        
        let request = makeURLRequestFromComponent(component: compoenet, headers: [
            NetworkHeader.clientId.rawValue : NetworkHeaderField.clientId.field,
            NetworkHeader.clientSecret.rawValue : NetworkHeaderField.clientSecret.field,
        ])
               
        return requestJSON(request)
            .map { $1 }
            .map { response -> MovieResult in
                print(response)
                let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let movieresult = try JSONDecoder().decode(MovieResult.self, from: data)
                return movieresult
            }
            
    }
    
    
    func searchMovieRx(query: String, start: Int) -> Observable<MovieResult> {
        let compoenet = makeURLComponents(url: Endpoint.searchMovie.urlString, params: [
            "query": query,
            "start" : "\(start)"
        ])!
        
        let request = makeURLRequestFromComponent(component: compoenet, headers: [
            NetworkHeader.clientId.rawValue : NetworkHeaderField.clientId.field,
            NetworkHeader.clientSecret.rawValue : NetworkHeaderField.clientSecret.field,
        ])
        
        return RxAlamofire
            .requestData(request)
            .debug()
            .observe(on: scheduler)
            .map { response, data -> MovieResult in
                return try JSONDecoder().decode(MovieResult.self, from: data)
            }
    }
    
    
    func makeURLComponents(url: String, params: [String: String]) -> URLComponents? {
        guard var component = URLComponents(string: url) else { return nil}
        component.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        return component
    }
    
    func makeURLRequestFromComponent(component: URLComponents, method: HTTPMethod = .GET, headers: [String : String]) -> URLRequest {
        var request = URLRequest(url: component.url!)
        request.httpMethod = method.rawValue
        
        headers.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
    
        return request
    }
}
