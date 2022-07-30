//
//  FirstCategoryResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/20.
//

import Foundation

struct LastCategoryResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [LastCategoryResult]
    
}


struct LastCategoryResult : Codable {
    
    let lastCategoryId : Int
    let lastCategory : String

    
 
}
