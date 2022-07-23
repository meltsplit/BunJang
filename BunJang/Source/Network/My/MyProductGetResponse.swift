//
//  MyProductGetResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/23.
//

import Foundation

struct MyProductGetResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [MyProductGetResult]
    
}


struct MyProductGetResult : Codable {
    
    let productImgs: [ProductImgs]
    let productId : Int
    let userId
    let price: Int
    let pay: Bool
    let title: String
    let updatedAt: String
}


