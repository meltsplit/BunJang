//
//  SecondCategoryResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/20.
//

import Foundation

struct SecondCategoryResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [SecondCategoryResult]
    
}

struct SecondCategoryResult : Codable {
    
    let firstCategoryId : Int
    let lastCategoryId : Int
    let lastCategory : String
    
}
