//
//  EndPoint.swift
//  BusanWelfareProgram
//
//  Created by jh on 8/15/24.
//

import Foundation

struct Endpoint {
    private var basePath: String
    var path: String {
        return basePath.hasPrefix("/") ? basePath : "/" + basePath
    }
    var method: HTTPMethod
    var headers: [String: String]
    var queryItems: [URLQueryItem]

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "apis.data.go.kr"
        components.path = path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        components.percentEncodedQuery = components.percentEncodedQuery?
            .replacingOccurrences(of: "+", with: "%2B")
        return components.url
    }
    
    init(path: String, method: HTTPMethod, headers: [String: String] = [:], queryItems: [URLQueryItem] = []) {
            self.basePath = path
            self.method = method
            self.headers = headers
            self.queryItems = queryItems
        }
}

enum HTTPMethod: String {
    case get = "GET"
}


enum NetworkError: Error {
    case invalidAPIKey
    case invalidURL
    case requestFailed(description: String)
    case noData
    case decodingFailed
    case httpResponseNotOK(statusCode: Int)
    case unknownError
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidAPIKey:
            return "API Key was invalid"
        case .invalidURL:
            return "The URL provided was invalid."
        case .requestFailed(let description):
            return "The network request failed: \(description)"
        case .noData:
            return "No data was returned by the server."
        case .decodingFailed:
            return "Failed to decode the data from the server."
        case .httpResponseNotOK(let statusCode):
            return "HTTP request returned an unsuccessful status code: \(statusCode)"
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
