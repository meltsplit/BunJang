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
    
    static var defaultImage = "https://www.vuescript.com/wp-content/uploads/2018/11/Show-Loader-During-Image-Loading-vue-load-image.png"
    static var productImageURL = "https://img.29cm.co.kr/next-product/2022/07/18/8732d52104224bba84307166c28145c7_20220718153123.jpg?width=700"
}
