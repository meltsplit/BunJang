//
//  MyProductGetResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/23.
//

import Foundation

struct UserProductGetResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [UserProductGetResult]
    
}


struct UserProductGetResult : Codable {
    
    let nickname : String
    let productImgs: [ProductImgs]
    let productId : Int
    let userId : Int
    let price: Int
    let pay: Bool
    let title: String
    let updatedAt: String
}


