//
//  User.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import Foundation

struct User : Codable{
    
    static let shared = User(id: "pinaex00", pwd: "12345", location: "양천구 신월동", phoneNum: "01099711712")
    
    
    let id : String
    let pwd : String
    let nickname : String = "파이내쁠"
    let location : String
    //let date : Date?
    let phoneNum : String
    
    
    
    
}


