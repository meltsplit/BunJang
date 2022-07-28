//
//  ProductsCollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/25.
//

import UIKit
import Kingfisher

class ProductsCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlet
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgPayImageView: UIImageView!
    
    @IBOutlet weak var heartBtn: UIButton!
    
    //MARK: - Properties
    
    var productId : Int?
    var myProductGetResult : UserProductGetResult?
    var productGetResult : ProductGetResult?
    var heartListResult : HeartListResult?
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        heartBtn.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .selected)
        heartBtn.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("prepareFor REsuse")
        priceLabel.text = ""
        titleLabel.text = ""
        heartBtn.isSelected = false
        heartBtn.tintColor = .white
        heartBtn.isHidden = false
    }
    
    //MARK: - IBOutlet
    
    @IBAction func heartBtnPressed(_ sender: UIButton) {
        heartBtn.isSelected = !heartBtn.isSelected
        if heartBtn.isSelected{
            heartBtn.tintColor = Color.Red
            
            // TODO: 찜 API
        } else{
            heartBtn.tintColor = .white
        }
        postHeart()
    }
    
    private func postHeart(){
        HeartPostManager.shared.pressHeart(productId: productId!, status: heartBtn.isSelected) { (response) in
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
    
    func setData(_ data: UserProductGetResult){
        myProductGetResult = data
        productId = data.productId
        
        productImageView.makeCornerRound(radius: 20)
        productImageView.kfSetImage(urlSting: data.productImgs[0].productImgUrl)
        
        
        priceLabel.text = makePriceString(data.price)
        titleLabel.text = data.title
        
            
        if !data.pay{ bgPayImageView.isHidden = true}
    }
    
    func setData(_ data: ProductGetResult){
        productGetResult = data
        productId = data.productId
        
        productImageView.makeCornerRound(radius: 20)
        productImageView.kfSetImage(urlSting: data.productImgs[0].productImgUrl)
        
        priceLabel.text = makePriceString(data.price)
        titleLabel.text = data.title
        
        if ( Int(User.shared.userId) == data.userId){
            heartBtn.isHidden = true
        }

        
        if data.heart{
            heartBtn.isSelected = true
            heartBtn.tintColor = Color.Red
        }
        if !data.pay{ bgPayImageView.isHidden = true}
    }
    
    func setData(_ data: HeartListResult){
        heartListResult = data
        
        productId = data.productId
        
        productImageView.makeCornerRound(radius: 20)
        productImageView.kfSetImage(urlSting: data.productImgs[0].productImgUrl)
        
        priceLabel.text = makePriceString(data.price)
        titleLabel.text = data.title
        
        if data.heart{
            heartBtn.isSelected = true
            heartBtn.tintColor = Color.Red
        } else{
            heartBtn.isSelected = false
            heartBtn.tintColor = .white
        }
            
        if !data.pay{ bgPayImageView.isHidden = true}
    }
    
    

}
