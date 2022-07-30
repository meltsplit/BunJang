//
//  AppDelegate.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit
import KakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        KakaoSDK.initSDK(appKey: Secret.KakaoNativeAppKey)
        
        tryAutoLogin()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func tryAutoLogin(){
        
        AutoLoginManager.shared.checkJWT { response in
            switch response {
            
            case .success(let data) :
                let responseData = data as! AutoLoginResponse
                
                if responseData.isSuccess{
                    self.checkAutoLogin(responseData.result!)
                }
                
            case .requestErr(let msg):
                print("requsertError")
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
    private func checkAutoLogin(_ data : AutoLoginResult){
        if data.isLoggedIn{
            print("자동 로그인 성공")
            
            User.shared.userId = String(data.userId)
            User.shared.jwt = data.jwt
            User.shared.isLogin = true
            
            NotificationCenter.default.post(name: NSNotification.Name("isLogin"), object: "true")
            
            
        } else{
            print("자동 로그인 실패")
            User.shared.userId = "1"
            User.shared.jwt = Secret.jwtToken1
            User.shared.isLogin = true
            return
        }
        
    }

}

