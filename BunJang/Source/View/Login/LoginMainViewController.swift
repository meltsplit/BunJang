//
//  LoginViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit
import ImageSlideshow
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginMainViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet var loginImageSlide :ImageSlideshow!
    
    //MARK: - Properties
    
    
    let onBoardingImage = [
        ImageSource(image: Image.login1),
        ImageSource(image: Image.login2),
        ImageSource(image: Image.login3),
        ImageSource(image: Image.login4),
                      ]
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(vcIdentifier)
        setImageSlideShow()
        
    }

    
    //MARK: - Custom Method
    
    private func setImageSlideShow(){
        
        loginImageSlide?.setImageInputs(onBoardingImage)
        
        let indicator = UIPageControl()
        indicator.currentPageIndicatorTintColor = UIColor.black
        indicator.pageIndicatorTintColor = UIColor.lightGray
        
        loginImageSlide.pageIndicator = indicator
    }
   
    //MARK: - IBAction
    
    @IBAction func kakaoLoginBtnPressed(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    guard let BaseVC = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarController") as? BaseTabBarController else { return }
                    
                    BaseVC.modalPresentationStyle = .fullScreen
                    
                    self.present(BaseVC, animated: true)
                    
                }
            }
        
    }
    @IBAction func appleLoginBtnPressed(_ sender: UIButton) {
        print("애플 로그인은 개발자 계정이 있어야 가능합니다.")
        User.shared.userId = "1"
        ProductPostManager.shared.postProduct(product: ProductPostModel(productImgs: [""], title: "123", firstCategoryId: 1, lastCategoryId: 1, tags: [""], price: 123123, contents: "123123123123123", amount: 123, isUsed: true, changeable: true, shippingFee: true, pay: true)) { (response) in
            switch response{
            case .success(let data):
                print(data as! ProductPostResponse)
            default: print("fail")
            }
        }
        
        
        
        
        
        
        
        
//        let userData = User.shared
//        SignUpManager.shared.postRegister(user: userData) { (result) in
//            
//            switch result{
//                
//            case .success(let data) :
//                print("성공")
//                let signUpData = (data as! SignUpResponse).result
//                
//                print(signUpData)
//            case .requestErr(let msg):
//                if let message = msg as? String {
//                    print(message)
//                }
//            case .pathErr :
//                print("pathErr")
//            case .serverErr :
//                print("serverErr")
//            case .networkFail:
//                print("networkFail")
//            }
//        }
      
    }
   
    
    @IBAction func autoLogin(_ sender: UIButton) {
        let mainTabVC = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarController") as! BaseTabBarController
        
        User.shared.id = "pinaex00"
        User.shared.pwd = "password"
        User.shared.nickname = "파이내쁠"
        User.shared.phoneNum = "010199711712"
        User.shared.location = "강서구 마곡동"
        User.shared.jwt = Secret.jwtToken
        User.shared.userId = "1"
        
        changeRootViewController(mainTabVC)
    }
}

extension LoginMainViewController {
    
}

