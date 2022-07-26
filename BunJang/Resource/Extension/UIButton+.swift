//
//  UIButton.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

// MARK: UIButton 내에 Indicator 표시
extension UIButton {
    
    var condition : Condition {
        switch self.tag{
        case 0: return .sell
        case 1: return .reservation
        case 2: return .soldOut
        default: return .sell
        }
           
    }
    
    var filter : Filter {
        switch self.tag{
        case 0: return .recent
        case 1: return .ascend
        case 2: return .descend
        default: return .recent
        }
           
    }
    
    func showIndicator() {
        let indicator = UIActivityIndicatorView()
        let buttonHeight = self.bounds.size.height
        let buttonWidth = self.bounds.size.width
        indicator.center = CGPoint(x: buttonWidth / 2, y: buttonHeight / 2)
        self.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func dismissIndicator() {
        for view in self.subviews {
            if let indicator = view as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
