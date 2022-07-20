//
//  Option.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/19.
//

import Foundation

struct OptionModel{
    
    var count: Int
    var state: String
    var change: String
    
    init() {
        self.count = 1
        self.state = State.old.rawValue
        self.change = Change.disable.rawValue
    }
    
    enum State : String{
        
        case old = "중고상품"
        case new = "새상품"
        
    }
    
    enum Change : String{
        
        case disable = "불가"
        case able = "가능"
        
    }
    
}
