//
//  SignUpResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/21.
//

import Foundation

struct PhoneRequestResponse : Codable {
    
    let isSuccess : Bool
    let code : Int
    let message : String
    let result : PhoneRequestResult?
}

struct PhoneRequestResult : Codable{
    let certNum : String
}
