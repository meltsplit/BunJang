//
//  UIStackView+.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/22.
//

import Foundation
import UIKit

extension UIStackView{
    
    func removeAllArrangedSubviews() {
            
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
                self.removeArrangedSubview(subview)
                return allSubviews + [subview]
            }
            
            // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
            
            // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func addArrangedSubViews(_ view: [UIView]){
        view.forEach {  self.addArrangedSubview($0)
        }
    }
    
}
