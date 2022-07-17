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
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setBar()
        setUI()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        self.modalPresentationStyle = .fullScreen
    }
    
    private func setBar(){
        true
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
