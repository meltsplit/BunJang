//
//  RecommendProductResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/23.
//

import Foundation

struct RecommendProductResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [ProductGetResult]
    
}
