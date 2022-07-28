//
//  productPostResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/22.
//

import Foundation

struct ProductPostResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : ProductPostResult?
    
}


struct ProductPostResult : Codable {
    
    let productId : Int
    
    
}
