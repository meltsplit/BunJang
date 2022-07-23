//
//  PostStartVC.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/24.
//

import Foundation
import UIKit

class PostStartVCViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    //MARK: - Properties
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let postVC = storyboard?.instantiateViewController(withIdentifier: "PostMainViewController") as! PostMainViewController
        present(postVC, animated: true)
        
        
    }
}

