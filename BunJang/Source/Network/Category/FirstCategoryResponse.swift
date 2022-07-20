//
//  FirstCategoryResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/20.
//

import Foundation

struct FirstCategoryResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [FirstCategoryResult]
    
}


struct FirstCategoryResult : Codable {
    
    let firstCategoryId : Int
    let firstCategory : String
    let categoryImgUrl : String
    
}
