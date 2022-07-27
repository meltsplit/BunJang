//
//  MyFollowingResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/28.
//

import Foundation

struct MyFollowingResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [MyFollowingResult]
}

struct MyFollowingResult : Codable {
    
    let userId: Int
    let profileImgUrl : String
    let nickname : String
    let productCount : Int
    let followerNum : Int
    let products : [FollowingProducts]

}

struct FollowingProducts : Codable{
    
    let productId : Int
    let productImgUrl : String
    let price : Int
    
}
