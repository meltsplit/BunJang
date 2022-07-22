//
//  MyProductCollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/23.
//

import UIKit

class MyProductCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var bgPayImageView: UIImageView!
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quickSellBtn: UIButton!
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        quickSellBtn.makeBorder(width: 1.3, color: .black)
        quickSellBtn.makeCornerRound(radius: 10)
        
    }
    
    //MARK: - Custom Method
    
    func setData(_ data : MyProductGetResult){
        productImageView.load(urlString: data.productImgs[0].productImgUrl)
        updatedAtLabel.text = data.updatedAt
        titleLabel.text = data.title
        priceLabel.text = makePriceString(data.price)
        if data.pay{
            bgPayImageView.isHidden = false
        } else{
            bgPayImageView.isHidden = true
        }
    }
    
    

}
