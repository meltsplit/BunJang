//
//  KeywordCollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/27.
//

import UIKit

class RecentSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var keywordLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func setData(_ data : RecentSearchResult){
        makeBorder(width: 1, color: .systemGray4)
        makeCornerRound(radius: 10)
        keywordLabel.text = data.keyword
    }
    
}
