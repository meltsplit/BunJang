//
//  UIView+.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit

extension UIView{
    
    func makeShadow(radius : CGFloat, offset : CGSize, opacity : Float){
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func makeCornerRound (radius : CGFloat){
        layer.cornerRadius = frame.height / radius
        layer.masksToBounds = false
        clipsToBounds = true
    }
    
    func makeBorder(width : CGFloat , color : UIColor ){
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
}
