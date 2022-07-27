//
//  MyPageResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/23.
//

import Foundation

struct HeartListResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [HeartListResult]
}

struct HeartListResult : Codable {

    let productImgs: [ProductImgs]
    let productId : Int
    let userId : Int
    let heart : Bool
    let pay: Bool
    let title: String
    let price: Int
    let updatedAt: String
    let profileImgUrl : String
    let nickname : String
}
