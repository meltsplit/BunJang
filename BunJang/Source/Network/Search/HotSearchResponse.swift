//
//  HeartResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/24.
//

import Foundation

struct HotSearchResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [HotSearchResult]
    
}


struct HotSearchResult : Codable {
    //let keywordId : Int
    let keyword : String
}
