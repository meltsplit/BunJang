//
//  URL.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import Foundation

struct API{
    
    static let baseURL = "http://221.153.137.164:9000"
    static let domainURL = "http://njeat.shop:9000"
    
    
    static let signUpURL = baseURL + "/app/users/sign-up"
    static let userURL = baseURL + "/app/users"
    
    
    static let bannerURL = baseURL + "/app/banner"
    static let productURL = baseURL + "/app/products"
    static let brandURL = baseURL + "/app/brands"
    static let searchURL = baseURL + "/app/search"
    
    static let firstCategoryURL = baseURL + "/app/categories"
    static let secondCategoryURL = baseURL + "/app/last/categories"
    
    static let myPageURL = userURL + "/my-page"
}

