//
//  SignUpResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/21.
//

import Foundation
struct SignUpResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : [BannerResult]
    
}


struct SignUpResult : Codable {
    
    let userId : Int
    let jwt : String
    
}
