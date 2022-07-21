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
        
        let userData = User.shared
        SignUpManager.shared.postRegister(user: userData) { (result) in
            
            switch result{
                
            case .success(let data) :
                print("성공")
                let signUpData = (data as! SignUpResponse).result
                
                print(signUpData)
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
      
    }
   
    
    @IBAction func autoLogin(_ sender: UIButton) {
        let mainTabVC = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarController") as! BaseTabBarController
        changeRootViewController(mainTabVC)
    }
}

extension LoginMainViewController {
    
}

