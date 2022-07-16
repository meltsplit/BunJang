//
//  User.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import Foundation

struct User{
    static let shared = User(id: "a", pwd: "a", name: "장석우", nickname: "멜트", address: "서울시 양천구 신월동")
    
    let id : String?
    let pwd : String?
    let name : String?
    let nickname : String?
    let address : String?
    
}
