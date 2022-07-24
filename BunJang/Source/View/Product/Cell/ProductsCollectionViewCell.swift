//
//  ProductsCollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/25.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlet
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgPayImageView: UIImageView!
    
    //MARK: - Properties
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(_ data: MyProductGetResult){
        productImageView.makeCornerRound(radius: 10)
        productImageView.load(urlString: data.productImgs[0].productImgUrl )
        priceLabel.text = String(data.price)
        titleLabel.text = data.title
        
        if !data.pay{ bgPayImageView.isHidden = true}
    }

}
