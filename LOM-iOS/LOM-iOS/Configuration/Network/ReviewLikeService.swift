//
//  ReviewLikeService.swift
//  LOM-iOS
//
//  Created by Junho Lee on 2021/11/29.
//

import Foundation
import Alamofire

struct ReviewLikeService{
    static let shared = ReviewLikeService()
        
    func putLikeCount(reviewId: Int, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let url = APIConstants.reviewLikeURL + "/\(reviewId)"
        let header: HTTPHeaders = [
            "content-Type" : "application/json"
            ]
        
        let dataRequest = AF.request(url,
                                     method: .put,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData { dataResponse in
            switch dataResponse.result{
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeGetInfoStatus(by: statusCode, value)
                completion(networkResult)
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    private func judgeGetInfoStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode{
        case 200: return isValidInfoData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidInfoData(data: Data) -> NetworkResult<Any>{
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(likeCountResponseData.self, from: data)
        else {return .pathErr}
        return .success(decodeData)
    }
}
