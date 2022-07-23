//
//  MyPageResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/23.
//

import Foundation

struct MyPageResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : MyPageResult
    
}


struct MyPageResult : Codable {
    
    let heartCnt : Int
    let reviewCnt : Int
    let followerCnt : Int
    let followingCnt: Int
}


