//
//  SecondCategoryCollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/26.
//

import UIKit

class SecondCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    func setData(_ data : SecondCategoryResult){
        
        categoryLabel.text = data.lastCategory
        print("\(data.lastCategory)")
    }
}
