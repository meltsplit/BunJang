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
    case decodeErr
    
}

//switch response {

//case .success(let data) :
//    let responseData = data as! MyProductGetResponse

//    self.setMyProduct(responseData.result)
//
//case .requestErr(let msg):
//    print(message)
//case .pathErr :
//    print("pathErr")
//case .serverErr :
//    print("serverErr")
//case .networkFail:
//    print("networkFail")
//}
//}
