//
//  BannerModel.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import Foundation

struct BannerResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [BannerResult]
    
}


struct BannerResult : Codable {
    
    let bannerImgUrl : String?
    let bannerName : String?
    
}
