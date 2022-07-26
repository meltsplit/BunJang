//
//  BaseTabBarController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit

class BaseTabBarController : UITabBarController , UITabBarControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        print("BaseTabController - viewDidLoad()")
        print(User.shared)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("~!~~!~!!~!~!~!~!탭바선택됨")
        
        if let title = viewController.title{
            
            if (title == "Search"){
                
//                var searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchMainViewController") as! SearchMainViewController
//                
//                
////                searchVC.modalPresentationStyle = .overFullScreen
////                navigationController?.pushViewController(searchVC, animated: true)
////
//                present(searchVC, animated: true)
            }
        }
    }
    
    
}

