//
//  UICollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit

extension UICollectionViewCell{
    static var cellIdentifier : String{return String(describing: self)}
    
    func makePriceString(_ int: Int)-> String?{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter.string(from: NSNumber(value: int))!+"원"
    }
}
