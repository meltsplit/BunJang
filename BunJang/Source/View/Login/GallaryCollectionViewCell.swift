//
//  GallaryCollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/29.
//

import UIKit

class GallaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    func setData(_ data : GallaryResult){
        profileImageView.kfSetImage(urlSting: data.galleryImgUrl)
    }
}
