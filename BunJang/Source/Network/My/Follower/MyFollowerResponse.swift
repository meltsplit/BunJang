//
//  MyPageResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/23.
//

import Foundation

struct MyFollowerResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [MyFollowerResult]
}

struct MyFollowerResult : Codable {
    
    let userId: Int
    let profileImgUrl : String
    let nickname : String
    let productCount : Int
    let followerNum : Int

}
