//
//  Product.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import Foundation
import UIKit

struct ProductModel: Codable {
    
    let image : String?
    let title : String?
    let price : Int?
    let heart : Int?
    
}

extension ProductModel{
    
    static var sampleData = [
        
        ProductModel(image: "event1", title: "이벤트1 팝니다", price: 50000, heart: 2),
        ProductModel(image: "event2", title: "이벤트2 팝니다", price: 70000, heart: 7),
        ProductModel(image: "event3", title: "이벤트3 팝니다vkfkfkfkfkfkfkfkfkskvvkfdkdy", price: 90000, heart: 5),
        ProductModel(image: "event4", title: "팝니다", price: 110000, heart: 0),
        ProductModel(image: "event1", title: "이벤트1 팝니다", price: 50000, heart: 2),
        ProductModel(image: "event2", title: "이벤트2 팝니다", price: 70000, heart: 7),
        ProductModel(image: "event3", title: "이벤트3 팝니다", price: 90000, heart: 5),
        ProductModel(image: "event4", title: "팝니다", price: 110000, heart: 0),
        ProductModel(image: "event1", title: "이벤트1 팝니다", price: 50000, heart: 2),
        ProductModel(image: "event2", title: "이벤트2 팝니다", price: 70000, heart: 7),
        ProductModel(image: "event3", title: "이벤트3 팝니다", price: 90000, heart: 5),
        ProductModel(image: "event4", title: "팝니다", price: 110000, heart: 0)
        
    ]
    
}

