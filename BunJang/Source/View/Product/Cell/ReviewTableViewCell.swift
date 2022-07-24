//
//  ReViewTableViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/24.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    
    //MARK: - Properties

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(_ data : TotalReviewResult){
        
        starLabel.text = String(data.star)
        contentsLabel.text = data.reviewContents
        nicknameLabel.text = data.nickname
        updatedAtLabel.text = data.updatedAt
    }
}
