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
    
    var vcIdentifier : String{return String(describing: self)}
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Custom Method
    
    func hideNavBar(){
        navigationController?.isNavigationBarHidden = true
    }
    
    func hideTabBar(){
        tabBarController?.tabBar.isHidden = true
    }
    
    func showNavBar(){
        navigationController?.isNavigationBarHidden = false
    }
    
    func showTabBar(){
        tabBarController?.tabBar.isHidden = false
    }
    
    func pushVC(_ viewController: UIViewController){
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popVC(){
        navigationController?.popViewController(animated: true)
    }
    
    func popVCNoAnimate(){
        navigationController?.popViewController(animated: false)
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
    
    
    func btnSelectedUI(_ btn: UIButton){
        btn.setTitleColor(Color.Red, for: .selected)
        btn.setTitleColor(UIColor.systemGray3, for: .normal)
        btn.isSelected = true
        btn.backgroundColor = Color.Pink
        btn.makeBorder(width: 1, color: Color.Pink)
    }
    
    func btnUnSelectedUI(_ btn: UIButton){
        btn.setTitleColor(Color.Red, for: .selected)
        btn.setTitleColor(UIColor.systemGray3, for: .normal)
        btn.isSelected = false
        btn.backgroundColor = .white
        btn.makeBorder(width: 1, color: UIColor.systemGray3)
    }
    
}
