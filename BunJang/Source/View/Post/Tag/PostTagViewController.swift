//
//  PostTagViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import UIKit

class PostTagViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    //MARK: - Properties
    
    var delegate : ArrayStringDelegate?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavBar()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        
    }
    
    private func setBar(){
        hideTabBar()
        hideNavBar()
    }
    
    private func setUI(){
        true
    }
    
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension PostTagViewController {
    
}

