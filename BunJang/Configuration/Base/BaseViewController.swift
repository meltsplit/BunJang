//
//  BaseViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import Foundation
import UIKit
class BaseViewController: UIViewController{
    
    //MARK: - Properties
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isTranslucent = false
        
    }
    
    //MARK: - Custom Method
    
    func hideNavBar(){
        navigationController?.isNavigationBarHidden = true
    }
    
    func hideTabBar(){
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = true
    }
    
    func showNavBar(){
        navigationController?.isNavigationBarHidden = false
    }
    
    func showTabBar(){
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.isHidden = false
    }
    
    func pushVC(_ viewController: UIViewController){
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popVC(){
        navigationController?.popViewController(animated: true)
    }
    
    func presentRightToLeft(_ viewControllerToPresent: UIViewController) {
            let transition = CATransition()
            transition.duration = 0.25
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            self.view.window!.layer.add(transition, forKey: kCATransition)

            present(viewControllerToPresent, animated: false)
        }
    
    func dismissLeftToRight() {
            let transition = CATransition()
            transition.duration = 0.25
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            self.view.window!.layer.add(transition, forKey: kCATransition)

            dismiss(animated: false)
        }
    
}
