//
//  HeartResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/24.
//

import Foundation

struct FollowingResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : FollowingResult
    
}


struct FollowingResult : Codable {
    
    let status : Bool
}
