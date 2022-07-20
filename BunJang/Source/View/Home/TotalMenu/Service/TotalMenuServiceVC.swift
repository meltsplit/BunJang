//
//  TotalMenuServiceVC.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/20.
//

import UIKit

class TotalMenuServiceVC : BaseViewController{
    
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
    
}

extension TotalMenuServiceVC {
    
}

