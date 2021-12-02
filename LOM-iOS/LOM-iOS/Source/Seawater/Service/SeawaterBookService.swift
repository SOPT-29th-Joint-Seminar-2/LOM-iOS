//
//  SeawaterBookService.swift
//  LOM-iOS
//
//  Created by 김혜수 on 2021/12/03.
//

import Foundation

import Alamofire

struct SeawaterBookService {
    
    static let shared = SeawaterBookService()
    
    // MARK: - 서점 베스트10
    func getbestbook(completion: @escaping (NetworkResult<Any>) -> Void) {
        AF.request(BookRouter.bestBook)
            .validate(statusCode: 200..<500)
            .responseData { res in
                switch res.result {
                case .success(let data):
                    switch res.response?.statusCode {
                    case 200:
                        guard let jsonData = try? JSONDecoder().decode(BestResponseData.self, from: data) else { return}
                        return completion(.success(jsonData))
                    default: completion(.networkFail)
                        
                    }
                case .failure(let err):
                    print(err)
                    
                }
            }
        
    }
}
