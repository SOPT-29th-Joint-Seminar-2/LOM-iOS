//
//  BookRouter.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/12/03.
//

import Foundation

import Alamofire

enum BookRouter: URLRequestConvertible {
    
    case bestBook
    case bookDetail(id: Int)
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .bestBook, .bookDetail: return .get
        }
    }
    
    var path: String {
        switch self {
        case .bestBook: return "/book"
        case .bookDetail(let id): return "/book/\(id)"
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .bestBook, .bookDetail: return ["Content-Type": "application/json"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.method = method
        request.headers = HTTPHeaders(headers)

        return request
    }
}
