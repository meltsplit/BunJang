//
//  RecommendProductCollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import UIKit

class RecommendProductCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var heartLabel: UILabel!
    
    //MARK: - Properties
    
    
    //MARK: - Custom Method
    
    func setData(_ data : ProductModel){
        productImageView.makeCornerRound(radius: 14)
        
        productImageView.image = UIImage(named: data.image!)
        priceLabel.text = "\(data.price!)원"
        titleLabel.text = data.title
        locationLabel.text = "양천구 신월동"
        timeLabel.text = "3분 전"
        
    }
    
    //MARK: - IBAction
    
    @IBAction func heartBtnPressed(_ sender: UIButton) {
        print("찜 버튼 클릭됨")
    }
    
}
