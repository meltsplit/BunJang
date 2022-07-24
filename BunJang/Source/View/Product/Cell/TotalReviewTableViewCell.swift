//
//  TotalReviewTableViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/24.
//

import UIKit

class TotalReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet var starList: [UIImageView]!
    @IBOutlet weak var contentsLabel: UILabel!
    
    
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var productId : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
//        delegate?.sendViewController(productVC)
        // Configure the view for the selected state
    }
    
    func setData(_ data: TotalReviewResult){
        
        productId = data.productId
        
        profileImageView.load(urlString: data.profileImgUrl)
        nicknameLabel.text = data.nickname
        contentsLabel.text = data.reviewContents
        updatedAtLabel.text = data.updatedAt
        titleLabel.text = data.title
        
        
        for i in 0..<5{
            if(i <= Int(data.star)){
                starList[i].tintColor = Color.Yellow
            } else {
                starList[i].tintColor = .systemGray2
                
            }
        }
        
    }
    
}
