//
//  PostViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

class PostMainViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var safePayView: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    
    //MARK: - Properties
    
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setBar(true)
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setBar(false)
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        return
    }
    
    private func setBar(_ bool: Bool){
        tabBarController?.tabBar.isHidden = bool
    }
    
    private func setUI(){
        cameraView.makeCornerRound(radius: 10)
        
        registerView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner,.layerMaxXMinYCorner)
        registerView.layer.addBorder([.top], color: UIColor.systemGray5, width: 1)
        
        
        
       safePayView.makeBorder(width: 2, cgColor: UIColor.systemGray5.cgColor)
       safePayView.makeCornerRound(radius: 10)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "category" {
//            let vc = segue.destination as! PostCategoryViewController
//        } else if segue.identifier == "tag" {
//            let vc = segue.destination as! PostTagViewController
//        }
        return
    }
    
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Tab", bundle: nil)
        
        guard let BaseVC = storyboard.instantiateViewController(withIdentifier: "BaseTabBarController") as? BaseTabBarController else { return }
        
        BaseVC.modalPresentationStyle = .fullScreen
        present(BaseVC, animated: false)
    }
    
    @IBAction func cameraBtnPressed(_ sender: UITapGestureRecognizer) {
        print("카메라 버튼 클릭")
    }
    
    @IBAction func optionBtnPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OptionBottomSheet") as! OptionBottomSheet
                
                // MDC 바텀 시트로 설정
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
                
                // 보여주기
        present(bottomSheet, animated: true, completion: nil)
    }
    
    
    
    
    
}

extension PostMainViewController {
    
}

