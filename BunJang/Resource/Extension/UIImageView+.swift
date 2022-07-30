//
//  UIImageView+.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/22.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView{
    
    func load(urlString: String){
        let url = URL(string: urlString) ?? URL(string: Default.defaultImage)!
        load(url: url)
    }

    func load(url: URL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            }
        }
        
    func kfSetImage(urlSting : String){
        let imageURL = URL(string: urlSting)
        kf.indicatorType = .activity
        kf.setImage(with: imageURL, placeholder: nil, options: [.transition(.fade(1.0))], progressBlock: nil)
    }
    
    
    func firstCategory(_ id : Int){
        switch id {
        case 1: image = UIImage(named: "신발")
        case 2: image = UIImage(named: "가방")
        case 3: image = UIImage(named: "시계:주얼리")
        case 4: image = UIImage(named: "패션 악세서리")
        case 5: image = UIImage(named: "음반:악기")
        case 6: image = UIImage(named: "디지털:가전")
        case 7: image = UIImage(named: "남성의류")
        case 8: image = UIImage(named: "차량:오토바이")
        case 9: image = UIImage(named: "스포츠:레저")
        case 10: image = UIImage(named: "가구:인테리어")
        default : "https://www.vuescript.com/wp-content/uploads/2018/11/Show-Loader-During-Image-Loading-vue-load-image.png"
        }
    }
    
    func lastCategory(_ id : Int){
        switch id {
        case 1: image = UIImage(named: "shoe")
        case 2: image = UIImage(named: "신발")
        case 3: image = UIImage(named: "신발")
        case 4: image = UIImage(named: "가방")
        case 5: image = UIImage(named: "가방")
        case 6: image = UIImage(named: "시계:주얼리")
        case 7: image = UIImage(named: "시계:주얼리")
        case 8: image = UIImage(named: "시계:주얼리")
        case 9: image = UIImage(named: "패션 악세서리")
        case 10: image = UIImage(named: "패션 악세서리")
        case 11: image = UIImage(named: "shoe")
        case 12: image = UIImage(named: "음반:악기")
        case 13: image = UIImage(named: "디지털:가전")
        case 14: image = UIImage(named: "디지털:가전")
        case 15: image = UIImage(named: "디지털:가전")
        case 16: image = UIImage(named: "여성의류")
        case 17: image = UIImage(named: "남성의류")
        case 18: image = UIImage(named: "bike")
        case 19: image = UIImage(named: "automobile")
        case 20: image = UIImage(named: "camp")
        case 21: image = UIImage(named: "스포츠:레저")
        case 22: image = UIImage(named: "가구:인테리어")
        case 23: image = UIImage(named: "가구:인테리어")
        default: image = UIImage(named: "스타굿즈")
        }
    }

    
}
