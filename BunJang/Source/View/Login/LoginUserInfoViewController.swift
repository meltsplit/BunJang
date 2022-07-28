//
//  LoginPhoneViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/29.
//

import Foundation
import UIKit

class LoginUserInfoViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var nicknameLineView: UIView!
    @IBOutlet weak var addressLineView: UIView!
    
    @IBOutlet weak var gallaryBtn: UIButton!
    
    //MARK: - Properties
    
    var nicknameData : String?
    var addressData : String?
    var imgURLData : String?
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        dismissKeyboardWhenTappedAround()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavBar()
        hideTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNavBar()
        showTabBar()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        
        nicknameTextField.delegate = self
        addressTextField.delegate = self
        
    }
    
    private func setUI(){
        okBtn.makeCornerRound(radius: 10)
        gallaryBtn.makeCornerRound(radius: 10)
    }
    
    private func goHome(){
        
        let mainTabVC = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarController") as! BaseTabBarController
        changeRootViewController(mainTabVC)
        
    }
    
    private func postRegister(){
        SignUpManager.shared.postRegister(nickname: nicknameData!, location: addressData!, phoneNum: DataCheet.shard.phoneNum, imageurl: Default.defaultImage) { response in
            switch response {
                        case .success(let data) :
                            let responseData = data as! SignUpResponse
                            if responseData.isSuccess{
                                self.presentBottomAlert(message: "회원가입에 성공하셨습니다")
                                
                                User.shared.userId = String(responseData.result.userId)
                                User.shared.jwt = responseData.result.jwt
                                
                                let mainTabVC = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarController") as! BaseTabBarController
                                self.changeRootViewController(mainTabVC)
                                
                                
                                
                                
                            } else {
                                self.presentBottomAlert(message: responseData.message)
                                }
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
                        case .decodeErr:
                            print("decodeError")
                        }
        }
    }
    
    
    //MARK: - IBAction
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        popVC()
    }
    
    @IBAction func okBtnPressed(_ sender: Any) {
        guard let nicknameText = nicknameTextField.text else {return }
        nicknameLineView.backgroundColor = .systemGray5
        nicknameData = !nicknameText.isEmpty ? nicknameText : nil
        
        guard let addressText = addressTextField.text else {return }
        addressLineView.backgroundColor = .systemGray5
        addressData = !addressText.isEmpty ? addressText : nil
        
        postRegister()
        
        
    }
    
}

extension LoginUserInfoViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag{
        case 0 : nicknameLineView.backgroundColor = .black
        case 1: addressLineView.backgroundColor = .black
        default: return
        }
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        dismissKeyboard()
        
        guard let text = textField.text else {return }
        
        switch textField.tag{
        case 0 : nicknameLineView.backgroundColor = .systemGray5
            nicknameData = !text.isEmpty ? text : nil
        case 1: addressLineView.backgroundColor = .systemGray5
            addressData = !text.isEmpty ? text : nil
        default : return
        }
        
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}

