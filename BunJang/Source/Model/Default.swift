//
//  Default.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/21.
//

import Foundation

struct Default{
   
    static let firstCategory = FirstCategoryResult(firstCategoryId: 1, firstCategory: "신발", firstCategoryImgUrl: Default.categoryDefaultImageURL)
    
    static let secondCategory = SecondCategoryResult(firstCategory: "신발", firstCategoryId: 1, firstCategoryImgUrl: Default.categoryDefaultImageURL, lastCategory: "스니커즈", lastCategoryId: 1, lastCategoryImgUrl: Default.categoryDefaultImageURL)
    
    static var categoryDefaultImageURL = "https://drive.google.com/file/d/17pIagEFMMiCUogGydGxyIITxtVZgWndt/view?usp=sharing"
    
    static var defaultImage = "https://en.pimg.jp/025/506/179/1/25506179.jpg"
    
    static var userID = "1"
}
