//
//  MenuCollectionCellCollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/20.
//

import UIKit

class MenuCollectionCell: UICollectionViewCell {
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    
    let menuImage = [
                        Image.heart,
                        Image.box,
                        Image.clock,
                        Image.cloth,
                        Image.best,
                        Image.shoe,
                        Image.graph,
                        Image.camp,
                        Image.location,
                        Image.bike,
                        Image.mail,
                        Image.star,
                        Image.menu,
                        Image.automobile,
                        
                        
                        Image.box,
                        Image.cloth,
                        Image.heart,
                        Image.clock,
                        Image.best,
                        Image.graph,
                        Image.location,
                        Image.mail,
                        Image.menu,
                        Image.shoe,
                        Image.camp,
                        Image.bike,
                        Image.star,
                        Image.automobile
    ]
    
    
    let menuText = [
                        "찜",
                        "메종키츠네",
                        "최근본상품",
                        "남성패딩점퍼",
                        "내피드",
                        "스니커즈",
                        "내폰시세",
                        "캠핑",
                        "우리동네",
                        "자전거",
                        "친구초대",
                        "스타굿즈",
                        "전체메뉴",
                        "오토바이",
                        
                        
                        
                        
                        "찜",
                        "최근본상품",
                        "내피드",
                        "내폰시세",
                        "우리동네",
                        "친구초대",
                        "전체메뉴",
                        "메종키츠네",
                        "남성패딩점퍼",
                        "스니커즈",
                        "캠핑",
                        "자전거",
                        "스타굿즈",
                        "오토바이",
                        
                  ]
    
    //MARK: - Life Cycle
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Custom Method

    func setData(_ indexPath: IndexPath){
        menuImageView.image = menuImage[ indexPath.row]
        menuLabel.text = menuText[ indexPath.row]
       
    }
}



