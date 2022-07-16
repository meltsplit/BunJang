//
//  LoginViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit
import ImageSlideshow

class LoginViewController : BaseViewController{
    
    //MARK: - IBOutlet
    @IBOutlet var loginImageSlide :ImageSlideshow?
    
    //MARK: - Properties
    let loginImage = [
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
        loginImageSlide?.setImageInputs(loginImage)
    }
   
    //MARK: - IBAction
    
    @IBAction func kakaoLoginBtnPressed(_ sender: UIButton) {
        
    }
    @IBAction func appleLoginBtnPressed(_ sender: UIButton) {
        
    }
   
    
}

extension LoginViewController {
    
}

