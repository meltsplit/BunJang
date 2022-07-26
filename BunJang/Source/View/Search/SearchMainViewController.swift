//
//  SearchMainViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit

class SearchMainViewController : BaseViewController{
    
    //MARK: - IBOutlet
    @IBOutlet weak var backBtn: UIButton!
    
    //MARK: - Properties
    var prevTab = true
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        hideNavBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        showTabBar()
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        true
    }
    
    private func setUI(){
        if prevTab{
            backBtn.isHidden = true
        }
    }
    
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        print("dismisws")
        
        popVC()
        
    }
}

extension SearchMainViewController {
    
}

