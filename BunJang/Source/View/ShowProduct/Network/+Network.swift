//
//  +Network.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/26.
//

import Foundation
extension ShowProductViewController {
    
    func getUserProducts(){
        UserProductGetManager.shared.getProduct(userID: userId! ,condition: Condition.sell ) { (response) in
            switch response {
            case .success(let data) :
                let responseData = data as! UserProductGetResponse
                if responseData.isSuccess{
                    self.setUserProduct(responseData.result!)
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
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
        CategoryProductManager.shared.getProducts(page: page, categoryId: categoryId!, isLast: isLastCategory, filter: filter) { response in
            
            switch response {
            
            case .success(let data) :
                
                let responseData = data as! CategoryProductResponse
                print("\(self.filter.rawValue)로 상품을 재조회 했습니다.")
                if responseData.isSuccess {
                    self.setProducts(responseData.result!)
                } else {
                    self.presentBottomAlert(message: responseData.message)
                }
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
        KeywordProductManager.shared.getProduct(keyword: keyword!, page: page, filter: filter) { response in
            switch response {
            
            case .success(let data) :
                
                let responseData = data as! KeywordProductResponse
                
                print("\(self.filter.rawValue)로 상품을 재조회 했습니다.")
                if responseData.isSuccess {
                    self.setProducts(responseData.result!)
                } else {
                    self.presentBottomAlert(message: responseData.message)
                }
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
    
}
