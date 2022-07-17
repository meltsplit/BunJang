//
//  BannerModel.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import Foundation

struct BannerModel : Codable {
    
    let result : [Banner]
    
    struct Banner : Codable {
        
        let bannerImgUrl : String?
        let bannerName : String?
        
    }
    
}

