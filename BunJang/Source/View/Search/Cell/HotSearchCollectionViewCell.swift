//
//  HotSearchCollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/27.
//

import UIKit

class HotSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    
    func setData(_ data : HotSearchResult){
        makeBorder(width: 1, color: .systemGray4)
        makeCornerRound(radius: 10)
        
        keywordLabel.text = data.keyword
    }
}
