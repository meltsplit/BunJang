//
//  MenuCollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    
    //MARK: - Properties
    
    let menuImage = [
                        Image.heart,
                        Image.clock,
                        Image.best,
                        Image.graph,
                        Image.location,
                        Image.mail,
                        Image.menu,
                        Image.box,
                        Image.cloth,
                        Image.shoe,
                        Image.camp,
                        Image.bike,
                        Image.star,
                        Image.automobile
    ]
    
    let menuText = [
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
                        "오토바이"
                  ]
    
    //MARK: - Custom Method

    func setData(_ indexPath: IndexPath){
        menuImageView.image = menuImage[indexPath.row]
        menuLabel.text = menuText[indexPath.row]
    }
}
