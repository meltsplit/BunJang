//
//  SignUpResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/21.
//

import Foundation
struct AutoLoginResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : AutoLoginResult?
    
}


struct AutoLoginResult : Codable {
    
    let isLoggedIn : Bool
    let userId : Int
    let jwt : String
    
}
