//
//  TotalReviewResponse.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/24.
//

import Foundation
import Alamofire

class TotalReviewManager{
    static let shared = TotalReviewManager()
    
    private var managerID: String{ return String(describing: self)}
    private init(){}
}

extension TotalReviewManager{
    
    func getProduct(productUserId : Int,completion: @escaping (NetworkResult<Any>) -> Void) {
        
        
        let url = API.reviewURL + "/" + String(productUserId)
        
        
        let header : HTTPHeaders = [
            
        ]
        
        let dataRequest = AF.request(
                                     url,
                                     method: .get,
                                     encoding: URLEncoding.default,
                                     headers: header
                                    )
        
        
        dataRequest.validate(statusCode: 200..<500).responseData { (response) in
            
                debugPrint(response)
                
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.value else { return }
             
                    let networkResult = self.judge(status: statusCode, data: data )
                    
                    completion(networkResult)
                    
                    
                    
                case .failure:
                    print("\(self.managerID)에서 failure 발생하였습니다.")
                    completion(.networkFail)
                }
        }
    }
    
    
    private func judge(status : Int, data : Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(TotalReviewResponse.self, from : data)
        else {
            print("\(managerID)에서 Decode를 실패하였습니다.")
            return .decodeErr
        }
        
        switch status{
        case 200..<300:
            print("\(self.managerID) - 통신 성공했습니다.")
            return .success(decodedData)
        case 400..<500 :
            print("\(self.managerID) - Request Error 발생했습니다.")
            return .requestErr(decodedData)
        case 500 :
            print("\(self.managerID) - Server Error 발생했습니다.")
            return .serverErr
        default :
            print("\(self.managerID) - NetWork Fail 입니다.")
            return .networkFail
            
            
        }
        
        
    }
    
}
