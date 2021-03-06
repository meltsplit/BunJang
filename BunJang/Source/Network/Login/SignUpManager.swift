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
    
    func postRegister(nickname: String, location: String,phoneNum: String, imageurl : String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = API.signUpURL
        url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let header : HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        
        let param : Parameters = [
            "id":"",
            "pwd":"",
            "nickname": nickname,
            "profileImgUrl": imageurl,
            "location": location,
            "phoneNum": phoneNum
                
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
            return .decodeErr
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
