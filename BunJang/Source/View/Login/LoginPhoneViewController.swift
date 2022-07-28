//
//  LoginPhoneViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/29.
//

import Foundation
import UIKit

class LoginPhoneViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    
    
    //MARK: - Properties
    
    var phoneNumData : String?
    
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNavBar()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        
        phoneTextField.delegate = self
    }
    
    private func setUI(){
        okBtn.makeCornerRound(radius: 10)
    }
    
    private func getCertification(){
        PhoneRequestManager.shared.requestNember(phoneNum: phoneNumData!) { response in
            switch response {
            case .success(let data) :
                let responseData = data as! PhoneRequestResponse
                if responseData.isSuccess{
                    
                    DataCheet.shard.phoneNum = self.phoneNumData!
                    let nextVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginCertificationViewController") as! LoginCertificationViewController
                    nextVC.certNum = responseData.result!.certNum
                    self.pushVC(nextVC)
                    
                    
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
    
    @IBAction func okBtnPressed(_ sender: UIButton) {
        
        guard let text = phoneTextField.text else {return }
        lineView.backgroundColor = .systemGray5
        phoneNumData = !text.isEmpty ? text : nil
        
        if phoneNumData != nil {
            
            getCertification()
            
        } else {
            presentBottomAlert(message: "전화번호를 입력해주세요")
        }
    }
    
}

extension LoginPhoneViewController : UITextFieldDelegate{
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            
            lineView.backgroundColor = .black
            
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            dismissKeyboard()
            
            guard let text = textField.text else {return }
            lineView.backgroundColor = .systemGray5
            phoneNumData = !text.isEmpty ? text : nil
            
        }
    
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.endEditing(true)
            return true
        }


}

