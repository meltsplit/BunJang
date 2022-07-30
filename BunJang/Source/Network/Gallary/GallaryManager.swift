//
//  FirstCategoryManager.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/20.
//

import Foundation
import Alamofire

struct GallaryManager {
    
    static let shared = GallaryManager()
    
    private var managerID: String{ return String(describing: self)}
    private init() {}
    
}

extension GallaryManager{
    
    func getGallary(completion : @escaping (NetworkResult<Any>) -> (Void) ){
     
        let url = API.baseURL + "/gallery"
        
        let dataRequest = AF.request(
                                     url,
                                     method: .get,
                                     encoding: URLEncoding.default
                                    )
        
        dataRequest.responseData{ response in
            debugPrint(response)
            
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else{ return }
                guard let data = response.value else{ return }
               
                completion(judge(status: statusCode, data: data))

            case .failure(let err):
                print("\(managerID)에서 failure 발생하였습니다.")
                print(err)
                completion(.networkFail)
            }
            
        }
        
        
    }
    
    private func judge(status : Int, data : Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GallaryResponse.self, from : data)
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
