//
//  HomeBannerManager.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import Foundation
import Alamofire

struct BannerManager {
    
    static let shared = BannerManager()
    private init() {}
    
}

extension BannerManager{
    
    func getBanner(completion : @escaping (NetworkResult<Any>) -> (Void) ){
     
        let url = API.bannerURL
        print(url)
        
        let dataRequest = AF.request(
                                     url,
                                     method: .get,
                                     encoding: URLEncoding.default
                                    )
        
        dataRequest.responseData{ response in
            
            debugPrint(response)
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else{
                    return
                }
                guard let data = response.value else{
                    return
                }
               
                completion(judge(status: statusCode, data: data))

            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
            
        }
        
        
    }
    
    private func judge(status : Int, data : Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(BannerModel.self, from : data) else{
            print("decode실패"); return .pathErr
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
