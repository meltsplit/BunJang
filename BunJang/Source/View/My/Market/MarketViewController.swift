//
//  MarketViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/28.
//

import UIKit

class MarketViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    //MARK: - Properties
    
    var userId : Int?
    
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



