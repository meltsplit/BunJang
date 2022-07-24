//
//  ProductGetResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/22.
//

import Foundation

struct ProductGetResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : ProductGetResult
    
}


struct ProductGetResult : Codable {
    
    let productId : Int
    let userId : Int
    let condition: String
    let productImgs: [ProductImgs]
    let price: Int
    let pay: Bool
    let title: String
    let location: String
    let updatedAt: String
    let viewCnt: Int
    let heartCnt: Int
    let chatCnt: Int
    let isUsed: Bool
    let amount: Int
    let shippingFee: Bool
    let changeable: Bool
    let contents: String
    
    let firstCategoryId : Int
    let firstCategoryImgUrl : String
    let firstCategory: String
    let lastCategoryId : Int
    let lastCategoryImgUrl: String
    let lastCategory : String
    
    let tags: [Tags]
    let profileImgUrl: String
    let nickname: String
    let star: Double
    let follower: Int
    let follow: Bool
    let commentCount: Int
    
    let heart : Bool
   
}

struct ProductImgs : Codable {
    let productImgUrl : String
}
struct Tags : Codable{
    let tagContents : String
}

