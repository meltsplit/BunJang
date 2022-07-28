//
//  FollowingCollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/28.
//

import UIKit
import Then
import SnapKit

class FollowingCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlet
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var productCntLabel: UILabel!
    @IBOutlet weak var followerCntLabel: UILabel!
    
    @IBOutlet weak var productsStackView: UIStackView!
    
    @IBOutlet var productImageViewList: [UIImageView]!
    @IBOutlet var productPriceLabelList: [UILabel]!
    
    @IBOutlet weak var bellBtn: UIButton!
    
    //MARK: - Properties
    
   
    
    //MARK: - Custom Method
    
    func setData(_ data : MyFollowingResult){
        profileImageView.kfSetImage(urlSting: data.profileImgUrl)
        profileImageView.makeCornerRound(radius: 2)
        nicknameLabel.text = data.nickname
        productCntLabel.text = String(data.productCount)
        followerCntLabel.text = String(data.followerNum)
        var check = true
        if data.productCount == 0 { }
        
        for i in 0..<3{
            if data.products.count == i { check = false }
            if check {
                productImageViewList[i].kfSetImage(urlSting: data.products[i].productImgUrl)
                productPriceLabelList[i].text = makePriceString(data.products[i].price)
                productImageViewList[i].makeCornerRound(radius: 15)
                productImageViewList[i].contentMode = .scaleAspectFill
                
                 
            }else{
                productImageViewList[i].isHidden = true
                productPriceLabelList[i].isHidden = true
            }
        }
        
        
        
        
    }
}
