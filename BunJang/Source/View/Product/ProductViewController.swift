//
//  ProductViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import UIKit

class ProductViewController : BaseViewController{
    
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
        super.viewWillDisappear(animated)
        setBar(false)
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        true
    }
    
    private func setBar(_ bool : Bool){
        navigationController?.isNavigationBarHidden = bool
        tabBarController?.tabBar.isTranslucent = bool
        tabBarController?.tabBar.isHidden = bool
        
    }
    
    private func setUI(){
        true
    }
    
    
    //MARK: - IBAction
    @IBAction func backBtnPressed(_ sender: UIButton) {
    
        navigationController?.popViewController(animated: true)
    }
    
}

extension ProductViewController {
    
}

