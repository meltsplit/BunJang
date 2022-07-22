//
//  LoginSignUpViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/20.
//

import Foundation
import UIKit

class LoginSignUpViewController : BaseViewController{
    
    //MARK: - IBOutlet
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    //MARK: - Properties
    
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("h2")
        
        setDelegate()
        setUI()
        
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        dismissKeyboardWhenTappedAround()
    }
    
    private func setUI(){
        
    }
    
    private func checkEmpty(){
        
//        let idText = idTextField.text
//        let pwdText = pwdTextField.text
//        let addressText = addressTextField.text
//        let phoneNumText = phoneNumTextField.text
//        
//       
//        let idEmpty = idText?.isEmpty ?? true
//        let pwdEmpty = pwdText?.isEmpty ?? true
//        let addressEmpty = addressText?.isEmpty ?? true
//        let phoneNumEmpty = phoneNumText?.isEmpty ?? true
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        //let date : Date = dateFormatter.date(from: birthDatePicker.date)
//        
//            
//        if (!idEmpty && !pwdEmpty && !addressEmpty && !phoneNumEmpty ) {
//            print("값 모두 입력됨")
//            signUpBtn.isEnabled = true
//            signUpBtn.backgroundColor = Color.Red
//            signUpBtn.makeBorder(width: 1, color: Color.Red)
//            popVC()
//            
//            let userData = User(id: idText!, pwd: pwdText!, location: addressText!, phoneNum: phoneNumText!)
//            SignUpManager.shared.postRegister(user: userData) { (result) in
//                
//                switch result{
//                case .success(let data) :
//                    print("성공")
//                case .requestErr(let msg):
//                    if let message = msg as? String {
//                        print(message)
//                    }
//                case .pathErr :
//                    print("pathErr")
//                case .serverErr :
//                    print("serverErr")
//                case .networkFail:
//                    
//                    print("networkFail")
//                }
//            }
//            
//            print(userData)
//            
//        } else {
//            print("값 모두 입력 안됨")
////                signUpBtn.isEnabled = false
////
////                signUpBtn.configuration.backgroundColor = .white
////                signUpBtn.makeBorder(width: 1, color: .systemGray3)
//        }
    }
    
    //MARK: - IBAction
    @IBAction func backBtnPressed(_ sender: UIButton) {
        popVC()
    }
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        
        
        self.checkEmpty()
        
    }
    
}


