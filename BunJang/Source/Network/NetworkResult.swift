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
//
//case .success(let data) :
//    let responseData = data as! MyProductGetResponse
//case .requestErr(let msg):
//    presentBottomAlert(message: msg as! String)
//case .pathErr :
//    print("pathErr")
//case .serverErr :
//    print("serverErr")
//case .networkFail:
//    print("networkFail")
//case .decodeErr:
//    print("decodeError")
//}
//
