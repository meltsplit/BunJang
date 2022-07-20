//
//  OptionBottomSheet.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/18.
//

import UIKit



class OptionBottomSheet : BaseViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var countTextField: UITextField!
    
    @IBOutlet var stateBtnList: [UIButton]!
    
    @IBOutlet var changeBtnList: [UIButton]!
    @IBOutlet weak var completeBtn: UIButton!
    
    //MARK: - Properties
    
    var delegate : optionDataDelegate?
    var optionData = OptionModel()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    //MARK: - Custom Method
    
    private func setUI(){
        self.view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner,.layerMaxXMinYCorner)
        view.makeCornerRound(radius: 40)
        
        
        countView.makeCornerRound(radius: 10)
        countView.makeBorder(width: 1, color: UIColor.systemGray3)
        
        stateBtnList.forEach {
            $0.makeCornerRound(radius: 10)
            $0.setTitleColor(Color.Red, for: .selected)
            $0.setTitleColor(UIColor.systemGray3, for: .normal)
            
        }
        stateBtnList[1].makeBorder(width: 1, color: UIColor.systemGray3)
        
        changeBtnList.forEach {
            $0.makeCornerRound(radius: 10)
            $0.setTitleColor(Color.Red, for: .selected)
            $0.setTitleColor(UIColor.systemGray3, for: .normal)
        }
        changeBtnList[1].makeBorder(width: 1, color: UIColor.systemGray3)
        
        completeBtn.makeCornerRound(radius: 10)
    }
    
    //MARK: - IBAction
    
    @IBAction func stateBtnPressed(_ sender: UIButton) {
        
        for btn in stateBtnList {
                   if btn == sender {
                       btn.isSelected = true
                       btn.backgroundColor = Color.Pink
                       btn.makeBorder(width: 1, color: Color.Pink)
                       
                       optionData.state = (btn.tag == 0) ? OptionModel.State.old.rawValue : OptionModel.State.new.rawValue
                       
                   } else {
                       btn.isSelected = false
                       btn.backgroundColor = .white
                       btn.makeBorder(width: 1, color: UIColor.systemGray3)

                   }
        }
    }
    
    @IBAction func changeBtnPressed(_ sender: UIButton) {
        
        for btn in changeBtnList {
                   if btn == sender {
                       btn.isSelected = true
                       btn.backgroundColor = Color.Pink
                       btn.makeBorder(width: 1, color: Color.Pink)
                       
                       optionData.change = (btn.tag == 0) ? OptionModel.Change.disable.rawValue : OptionModel.Change.able.rawValue
                       
                       
                   } else {
                       btn.isSelected = false
                       btn.backgroundColor = .white
                       btn.makeBorder(width: 1, color: UIColor.systemGray3)

                   }
        }
    }
    
    @IBAction func completeBtnPressed(_ sender: UIButton) {
        var count = 1
        let text = countTextField.text!
        if (!text.isEmpty && text != "0") { count = Int(text)! }
        
        optionData.count = count
        self.dismissKeyboard()
        dismiss(animated: true)
        
       delegate?.sendData(optionData)
    }
    
    
}

extension OptionBottomSheet : UITextFieldDelegate{
    
    // TODO: 최대자릿수 3자리까지 제한하기
   
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//
//
//    }

}


