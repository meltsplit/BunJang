//
//  TotalReviewResult.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/24.
//

import Foundation

struct TotalReviewResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [TotalReviewResult]
    
}


struct TotalReviewResult : Codable {
    
    let productId : Int
    let profileImgUrl: String
    let nickname: String
    let star: Double
    let reviewContents: String
    let title : String
    let updatedAt: String
   
}


