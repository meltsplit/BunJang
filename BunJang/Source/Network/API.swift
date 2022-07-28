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
    static let base1URL = "http://13.209.204.136:9000"
    
   static let phoneRequestURL = baseURL + "/app/messages/code"
    
    static let userURL = baseURL + "/app/users"
    static let kakaoURL = userURL + "/kakao"
    
    static let bannerURL = baseURL + "/app/banner"
    static let productURL = baseURL + "/app/products"
    static let brandURL = baseURL + "/app/brands"
    static let searchURL = baseURL + "/app/search"
    static let firstCategoryURL = baseURL + "/app/categories"
    static let secondCategoryURL = baseURL + "/app/last/categories"
    static let followURL = baseURL + "/app/follows"
    
    
    
    static let kakaoAutoURL = kakaoURL + "/auto/log-in"
    
    static let signUpURL = userURL + "/sign-up"
    static let myPageURL = userURL + "/my-page"
    static let heartListURL = userURL + "/heart-list"
    static let reviewURL = userURL + "/shop/reviews"
    
    static let followerURL = followURL + "/to-me"
    static let followingURL = followURL + "/to-you"
    
    static let categoryURL = productURL + "/categories"
    
    static let recentSearchURL = searchURL + "/log"
    static let hotSearchURL = searchURL + "/hot-keywords"
}

