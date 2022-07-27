//
//  DataCheat.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/23.
//

import Foundation

struct DataCheet{
    static var shard = DataCheet()
    
    var height = 350
    var filter = Filter.recent
    var prevPost = false
    var productId = 0
    private init() {}
}
