//
//  PostModel.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/22.
//

import Foundation

struct ProductPostModel{
    
    var productImgs : [String]
    var title : String
    var firstCategoryId : Int
    var lastCategoryId : Int
    var tags : [String]
    var price : Int
    var contents : String     
    var amount : Int           // 1
    var isUsed : Bool          // true
    var changeable : Bool      // false
    var shippingFee : Bool     // false
    var pay : Bool             // false
    
}
