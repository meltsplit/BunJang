//
//  LoginPhoneViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/29.
//

import Foundation
import UIKit

class LoginCertificationViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var certificationTextField: UITextField!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    //MARK: - Properties
    
    var authCode : String?
    var certNum : String?
    
    
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
        certificationTextField.delegate = self
    }
    
    private func setUI(){
        okBtn.makeCornerRound(radius: 10)
    }
    
    
    //MARK: - IBAction
    @IBAction func backBtnPressed(_ sender: Any) {
        popVC()
    }
    @IBAction func okBtnPressed(_ sender: Any) {
        
        guard let text = certificationTextField.text else {return }
        lineView.backgroundColor = .systemGray5
        authCode = !text.isEmpty ? text : nil
        
        
        
        
        if authCode != nil {
            if authCode == certNum {
                
                let nextVC = storyboard?.instantiateViewController(withIdentifier: "LoginUserInfoViewController") as! LoginUserInfoViewController
                pushVC(nextVC)
            } else {
                messageLabel.text = "인증번호가 일치하지 않습니다."
                messageLabel.textColor = Color.Red
                lineView.backgroundColor = Color.Red
            }
            
        } else {
            presentBottomAlert(message: "인증번호를 입력해주세요")
        }
    }
    
    
}

extension LoginCertificationViewController :UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        lineView.backgroundColor = .black
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        dismissKeyboard()
        
        guard let text = textField.text else {return }
        lineView.backgroundColor = .systemGray5
        authCode = !text.isEmpty ? text : nil
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}

