//
//  APIEnum.swift
//  MyNewExampleTest
//
//  Created by bro on 2022/07/26.
//

import Foundation

enum NetworkHeader: String {
    case accept = "Accept"
    case authorization = "Authorization"
}

enum NetworkHeaderField {
    case gitAuthorization
    case accept
    
    var field: String {
        switch self {
        case .gitAuthorization: return "token \(Config.clientId)"
        case .accept: return "application/vnd.github.v3+json"
        }
    }
}

enum NaverStatusCode: Int {
    case ok = 200
}

enum NaverSearchError: Int, Error {

    case notModified = 304
    case unAuthorization = 401
    case notFound = 404
    case validationFailed = 422
    case unavailable = 503
    case unknown
    case failed
    case invalidResponse
    case noData
    case invalidData


    var description: String { self.errorDescription }
}

extension NaverSearchError {
    var errorDescription: String {
        switch self {
        case .notModified: return "304: Not Modified"
        case .unAuthorization: return "401: Authorization Error"
        case .notFound: return "404: Not Found"
        case .validationFailed: return "422: Validation Failed"
        case .unavailable: return "503: Unavailable"
        case .failed: return "네트워크통신 실패"
        case .invalidData: return "시리얼라이즈 실패"
        default: return "UN_KNOWN_ERROR"
        }
    }
}
