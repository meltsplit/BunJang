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
    
    var userID: Int?
    var productID: Int?
   
    
    //MARK: - IBAction
    
    @IBAction func heartBtnPressed(_ sender: UIButton) {
        print("찜 버튼 클릭됨")
    }
    
    //MARK: - Custom Method
    
    func setData(_ data : ProductGetResult){
        self.userID = data.userId
        self.productID = data.productId
        
        productImageView.makeCornerRound(radius: 14)
        productImageView.load(urlString: data.productImgs[0].productImgUrl)
        priceLabel.text = makePriceString(data.price)
        titleLabel.text = data.title
        locationLabel.text = data.location
        timeLabel.text = data.updatedAt
        
        

    }
    
//    func setData(_ data : ProductModel){
//            productImageView.makeCornerRound(radius: 14)
//            productImageView.load(urlString: "https://img.29cm.co.kr/next-product/2022/07/18/8732d52104224bba84307166c28145c7_20220718153123.jpg?width=700")
//            priceLabel.text = makePriceString(data.price!)
//            titleLabel.text = data.title
//            locationLabel.text = "강서구 마곡동"
//            timeLabel.text = "3일 전"
//
//        }

    
}
