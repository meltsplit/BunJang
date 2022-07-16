//
//  LoginViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit

class LoginViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    //MARK: - Properties
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setBar()
        setUI()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        true
    }
   
    private func setBar(){
        true
    }
    
    private func setUI(){
        true
    }
    
    private func goHomeVC(){
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        guard let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeMainViewController") as? HomeMainViewController else { return }
        
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true)
        
    }
   
    //MARK: - IBAction
    
    @IBAction func autoLogin(_ sender: UIButton) {
        goHomeVC()
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        guard let id = idTextField.text else { return }
        guard let pwd = pwdTextField.text else { return }
        
        if (id == User.shared.id && pwd == User.shared.pwd){
            goHomeVC()
        }
    }
    
}

extension LoginViewController {
    
}


