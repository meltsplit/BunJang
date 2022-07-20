//
//  Default.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/21.
//

import Foundation

struct Default{
    
    static let firstCategory = FirstCategoryResult(firstCategoryId: 1, firstCategory: "신발", firstCategoryImgUrl: Image.categoryDefaultImageURL)
    
    static let secondCategory = SecondCategoryResult(firstCategory: "신발", firstCategoryId: 1, firstCategoryImgUrl: Image.categoryDefaultImageURL, lastCategory: "스니커즈", lastCategoryId: 1, lastCategoryImgUrl: Image.categoryDefaultImageURL)
}
