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

