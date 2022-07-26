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
    @IBOutlet weak var bgPayLogo: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var heartLabel: UILabel!
    
    //MARK: - Properties
    
    var userID: Int?
    var productID: Int?
   
    
    //MARK: - IBAction
    
    @IBAction func heartBtnPressed(_ sender: UIButton) {
        print("찜 버튼 클릭됨")
        heartBtn.isSelected = !heartBtn.isSelected
        if heartBtn.isSelected{
            heartBtn.tintColor = Color.Red
            
            // TODO: 찜 API
        } else{
            heartBtn.tintColor = .white
        }
        print("isSelected \(heartBtn.isSelected)")
        postHeart()
    }
    
    //MARK: - Custom Method
    
    private func postHeart(){
        HeartPostManager.shared.pressHeart(productId: productID!, status: heartBtn.isSelected) { (response) in
            switch response {

            case .success(let data) :
                print("찜하기 성공적으로 통신했습니다.")
            case .requestErr(let msg):
                print("찜하기 요청에러가 발생했습니다.")
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .decodeErr:
                print("decodeError")
            }
        }
    }
    
    func setData(_ data : ProductGetResult){
        
        self.userID = data.userId
        self.productID = data.productId
        
        productImageView.makeCornerRound(radius: 14)
        
        let imageURL = URL(string: data.productImgs[0].productImgUrl)
        productImageView.kf.indicatorType = .activity
        productImageView.kf.setImage(with: imageURL, placeholder: nil, options: [.transition(.fade(2.0))], progressBlock: nil)
        
        priceLabel.text = makePriceString(data.price)
        titleLabel.text = data.title
        locationLabel.text = data.location
        timeLabel.text = data.updatedAt
        
        if ( !data.pay) { bgPayLogo.isHidden = true}
        if ( Int(User.shared.userId) == data.userId){
            heartBtn.isHidden = true
        }
        else{
            heartBtn.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .selected)
            heartBtn.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            
        }
        if data.heart{
            heartBtn.isSelected = true
            heartBtn.tintColor = Color.Red
        }
    }
    

    
}
