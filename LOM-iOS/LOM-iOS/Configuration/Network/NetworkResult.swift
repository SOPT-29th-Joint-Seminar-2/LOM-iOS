//
//  NetworkResult.swift
//  LOM-iOS
//
//  Created by Junho Lee on 2021/11/28.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
