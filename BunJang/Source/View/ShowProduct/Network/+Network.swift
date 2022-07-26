//
//  +Network.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/26.
//

import Foundation
extension ShowProductViewController {
    
    func getCategory(){
        SecondCategoryManager.shared.getSecondCategory(categoryId!) { response in
            switch response {
            
            case .success(let data) :
                print(data)
                let responseData = data as! SecondCategoryResponse
                self.setCategory(responseData.result)
            case .requestErr(let msg):
                print("요청에러")
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .decodeErr:
                print("decodeError")
            }
            
        }
    }
    
    func getCategoryProducts(){
        CategoryProductManager.shared.getProducts(page: page, categoryId: categoryId!, isLast: isLastCategory) { response in
            switch response {
            
            case .success(let data) :
                
                let responseData = data as! CategoryProductResponse
                self.setCategoryProduct(responseData.result)
                
            case .requestErr(let msg):
                print("요청에러")
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .decodeErr:
                print("decodeError")
            }
        }
    }
    
    func getKeywordProducts(){
        
        
    }
    
}
