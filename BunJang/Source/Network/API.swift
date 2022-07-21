//
//  URL.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import Foundation

struct API{
    
    static let baseURL = "http://221.153.137.164:9000"
    static let server1 = "http://njeat.shop:9000"
    
    
    static let bannerURL = baseURL + "/app/banner"
    static let userURL = baseURL + "/app/users"
    static let productURL = baseURL + "/app/products"
    static let brandURL = baseURL + "/app/brands"
    static let searchURL = baseURL + "/app/search"
    
    static let signUpURL = baseURL + "/app/users/sign-up"
    
    static let firstCategoryURL = baseURL + "/app/categories"
    static let secondCategoryURL = baseURL + "/app/last/categories/" //path Variable
}
