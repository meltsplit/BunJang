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
        kf.setImage(with: imageURL, placeholder: nil, options: [.transition(.fade(2.0))], progressBlock: nil)
    }

    
}
