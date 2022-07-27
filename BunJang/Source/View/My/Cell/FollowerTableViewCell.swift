//
//  FollowerTableViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/28.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var productCntLabel: UILabel!
    @IBOutlet weak var followerCntLabel: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        
    }
    
    
    func setData(_ data : MyFollowerResult){
        
        profileImageView.makeCornerRound(radius: 2)
        profileImageView.makeBorder(width: 1, color: .systemGray5)
        nextBtn.makeCornerRound(radius: 2)
        nextBtn.makeBorder(width: 1, color: .systemGray5)
        
        profileImageView.kfSetImage(urlSting: data.profileImgUrl)
        nicknameLabel.text = data.nickname
        productCntLabel.text = "상품 \(data.productCount)"
        followerCntLabel.text = "팔로워 \(data.followerNum)"
    }

}
