//
//  Option.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/19.
//

import Foundation

struct OptionModel{
    
    var amount: Int
    var isUsed: Bool
    var changeable: Bool
    
    init() {
        self.amount = 1
        self.isUsed = true
        self.changeable = false
    }
    
    
    
}

//enum State : String{
//
//    case old = "중고상품"
//    case new = "새상품"
//
//}
//
//enum Change : String{
//
//    case disable = "불가"
//    case able = "가능"
//
//}
