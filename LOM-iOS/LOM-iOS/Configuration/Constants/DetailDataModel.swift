//
//  DetailDataModel.swift
//  LOM-iOS
//
//  Created by Junho Lee on 2021/11/29.
//

import Foundation
import UIKit

struct detailReviewTVData{
    let username: String
    let date: String
    let review: String
    let imageName: String
    var likeCount: Int
    var updatedLike: Int
    let reviewId: Int
    var rank: Int
    var staticReviewId: Int
    
    func makeImage() -> UIImage? {
        return UIImage(named: imageName)
    }
}
