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
    
    @IBOutlet weak var phoneAuthBtn: UIButton!
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
        
        print("LoginVC - viewDidLoad()")
        NotificationCenter.default.addObserver(self, selector: #selector(goHome(_:)), name: NSNotification.Name("isLogin"), object: nil)
        

        if User.shared.isLogin{
            let mainTabVC = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarController") as! BaseTabBarController
            changeRootViewController(mainTabVC)
        }
        
        print(vcIdentifier)
        setImageSlideShow()
        setUI()
        
    }

    
    //MARK: - Custom Method
    
    private func setUI(){
        phoneAuthBtn.makeCornerRound(radius: 2)
        phoneAuthBtn.makeBorder(width: 1, color: .black)
    }
    
    private func setImageSlideShow(){
        
        loginImageSlide?.setImageInputs(onBoardingImage)
        loginImageSlide.contentMode = .scaleAspectFit
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
        pageIndicator.pageIndicatorTintColor = UIColor.black
        loginImageSlide.pageIndicator = pageIndicator
        loginImageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        
        
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
        
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "LoginPhoneViewController") as! LoginPhoneViewController
        pushVC(nextVC)
    }
   
    
    
    
    
    //        UIStoryboard(name: "ShowProduct", bundle: nil)
    //        let categoryProductVC = UIStoryboard(name: "ShowProduct", bundle: nil).instantiateViewController(withIdentifier: "ShowProductViewController") as! ShowProductViewController
    //        categoryProductVC.show = Show.firstCategoryProduct
    //        categoryProductVC.categoryId = 1
    //        pushVC(categoryProductVC)
    
    @IBAction func autoLogin(_ sender: UIButton) {
        
        User.shared.jwt = Secret.jwtToken1
        User.shared.userId = "1"
        
        
        let mainTabVC = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarController") as! BaseTabBarController
        changeRootViewController(mainTabVC)
    }
    
    @objc func goHome(_ notification: Notification) {
            
        let mainTabVC = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarController") as! BaseTabBarController
        changeRootViewController(mainTabVC)
            
    }
}

extension LoginMainViewController {
    
}

