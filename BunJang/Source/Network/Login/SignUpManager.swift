//
//  SignUpManager.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/20.
//

import Foundation
import Alamofire

class SignUpManager{
    static let shared = SignUpManager()
    
    private var managerID: String{ return String(describing: self)}
    private init(){}
}

extension SignUpManager{
    
    func postRegister(user: User, completion: @escaping (NetworkResult<Any>) -> Void) {
        
//        let token = UserDefaults.standard.string(forKey: "token") ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjEwMDk5MjQwLCJleHAiOjE2MzYwMTkyNDAsImlzcyI6ImJlbWUifQ.JeYfzJsg-kdatqhIOqfJ4oXUvUdsiLUaGHwLl1mJRvQ"
        
//        let header: HTTPHeaders = [
//            "Content-Type":"application/json",
//            "token": token
//        ]
        
        let url = API.signUpURL
        
        
        let header : HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        
        let param : Parameters = [
            "id": user.id,
            "pwd": user.pwd,
            "nickname": user.nickname,
            "profileImgUrl": "",
            "location": user.location,
            "phoneNum": user.phoneNum
                
        ]
    
        
        
        let dataRequest = AF.request(
                                     url,
                                     method: .post,
                                     parameters: param,
                                     encoding: JSONEncoding.default,
                                     headers: header
                                    )
        
        
        dataRequest.validate(statusCode: 200..<500).responseData { (response) in
            
                debugPrint(response)
                
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let value = response.value else { return }
                    
                    let networkResult = self.judge(status: statusCode, data: value )
                    
                    completion(networkResult)
                    
                    
                    
                case .failure:
                    print("\(self.managerID)에서 failure 발생하였습니다.")
                    completion(.networkFail)
                }
        }
    }
    
    
    private func judge(status : Int, data : Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(SignUpResponse.self, from : data)
        else {
            print("\(managerID)에서 Decode를 실패하였습니다.")
            return .pathErr
        }
        
        switch status{
        case 200..<300:
            return .success(decodedData)
        case 400..<500 :
            return .requestErr(decodedData)
        case 500 :
            return .serverErr
        default :
            return .networkFail
            
            
        }
        
        
    }
    
}
