//
//  NetworkResult.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import Foundation

enum NetworkResult<T> {
    
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
    
}

//private func getCategory(){
//    FirstCategoryManager.shared.getFirstCategory { (response) in
//        switch response{
//        case .success(let data) :
//            
//            self.setFirstCategory(data as! FirstCategoryResponse)
//            
//        case .requestErr(let msg):
//            if let message = msg as? String {
//                print(message)
//            }
//        case .pathErr :
//            print("pathErr")
//        case .serverErr :
//            print("serverErr")
//        case .networkFail:
//            print("networkFail")
//        }
//    }
//}
