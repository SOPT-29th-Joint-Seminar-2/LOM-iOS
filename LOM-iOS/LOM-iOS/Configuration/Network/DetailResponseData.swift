//
//  DetailResponseData.swift
//  LOM-iOS
//
//  Created by Junho Lee on 2021/11/28.
//

import Foundation

// MARK: - DetailResponseData
struct DetailResponseData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: DetailResultData?
}

// MARK: - DataClass
struct DetailResultData: Codable {
    let bookInfoList: BookInfoList
    let reviewList: [ReviewList]
}

// MARK: - BookInfoList
struct BookInfoList: Codable {
    let completePercent: Int
    let bookImg: String
    let bookName, author, userStorage: String
    let postCount: Int
    let bookInfoListDescription, category: String
    let reviewPoint: Int
    let postSize, createdAt, updatedAt: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case completePercent, bookImg, bookName, author, userStorage, postCount
        case bookInfoListDescription = "description"
        case category, reviewPoint, postSize, createdAt, updatedAt, id
    }
}

// MARK: - ReviewList
struct ReviewList: Codable {
    let id: Int
    let userImg: String?
    let nickname: String
    let createdAt, updatedAt: String?
    let contents: String
    let likeCount: Int
}


// MARK: - likeCountResponseData
struct likeCountResponseData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: likeCountClass?
}

// MARK: - DataClass
struct likeCountClass: Codable {
    let like: Int
}

// MARK: - postReviewResponseData
struct postReviewResponseData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: PostReviewClass?
}

// MARK: - DataClass
struct PostReviewClass: Codable {
    let reviewID: Int

    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
    }
}
