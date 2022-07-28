//
//  GetNetwork.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/25.
//

import Foundation

extension ProductViewController{
    
    func getProduct(){
        
        ProductGetManager.shared.getProduct(productId: productId!) { (response) in
            switch response {
            case .success(let data) :
                let responseData = data as! ProductGetResponse
                self.setProduct(responseData.result)
                
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
            case .pathErr :
                print("pathErr")
            case .decodeErr:
                print("decodeError")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    func getUserProducts(){
        UserProductGetManager.shared.getProduct(userID: userID! ,condition: Condition.sell ) { (response) in
            switch response {
            case .success(let data) :
                let responseData = data as! UserProductGetResponse
                if responseData.isSuccess{
                    self.setUserProduct(responseData.result!)
                } else {
                    self.presentBottomAlert(message: responseData.message)
                }
                self.resizeCollectionView()
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
    
    func getTotalReview(){
        TotalReviewManager.shared.getProduct(productUserId : userID! ) { response in
            switch response {
            
            case .success(let data) :
                let responseData = data as! TotalReviewResponse
                self.setTotalReview(responseData.result)
                self.resizeTableView()
                
            case .requestErr(let msg):
                self.presentBottomAlert(message: msg as! String)
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
    
    func postHeart(){
        HeartPostManager.shared.pressHeart(productId: productId!, status: wishBtn.isSelected) { (response) in
            switch response {

            case .success(let data) :
                let responseData = data as! HeartPostResponse
                self.getProduct()
            case .requestErr(let msg):
                self.presentBottomAlert(message: msg as! String)
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
    
    func postFollow(){
        FollowingManager.shared.following(followUserId: userID!, status: followBtn.isSelected) { response in
            switch response {
            
            case .success(let data) :
                print("팔로잉 하였습니다.")
                
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
