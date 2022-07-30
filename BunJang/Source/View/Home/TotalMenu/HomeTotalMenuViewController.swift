//
//  HomeTotalMenuViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/20.
//

import UIKit

class HomeTotalMenuViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    //MARK: - Properties
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        
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
        true
    }
    
    private func setUI(){
        true
    }
    
    
    //MARK: - IBAction
    @IBAction func backBtnPressed(_ sender: UIButton) {
        popVC()
        dismiss(animated: true)
    }
    
}

extension HomeTotalMenuViewController {
    
}

