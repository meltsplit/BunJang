//
//  User.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import Foundation

struct User : Codable{
    
    static var shared = User()
    
    
    var id : String?
    var pwd : String?
    var nickname : String?
    var location : String?
    //let date : Date?
    var phoneNum : String?
    
    var userId : String = "0"
    var jwt : String = "Default JWT Token"
    var isLogin : Bool?
    
    private init(){}
    
}


