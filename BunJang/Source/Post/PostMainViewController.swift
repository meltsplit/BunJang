//
//  PostViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit

class PostMainViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
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
        true
    }
    
    private func setBar(_ bool: Bool){
        tabBarController?.tabBar.isHidden = bool
    }
    
    private func setUI(){
        true
    }
    
    
    //MARK: - IBAction
    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        print("backBtn pressed")
        let storyboard = UIStoryboard(name: "Tab", bundle: nil)
        
        guard let BaseVC = storyboard.instantiateViewController(withIdentifier: "BaseTabBarController") as? BaseTabBarController else { return }
        
        BaseVC.modalPresentationStyle = .fullScreen
        present(BaseVC, animated: true)
    }
    
}

extension PostMainViewController {
    
}

