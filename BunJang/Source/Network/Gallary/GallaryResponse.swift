//
//  FirstCategoryResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/20.
//

import Foundation

struct GallaryResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [GallaryResult]
    
}


struct GallaryResult : Codable {
    
    let galleryId : Int
    let galleryImgUrl : String
    
 
}
