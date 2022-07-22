//
//  UIImageView+.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/22.
//

import Foundation
import UIKit
extension UIImageView{
func load(urlString: String){
    let url = URL(string: urlString)
    load(url: url!)
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
}
