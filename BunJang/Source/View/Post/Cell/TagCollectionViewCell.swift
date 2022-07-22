//
//  TagCollectionViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/21.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagView: UIView!
    
    var delegate : StringDelegate?
   
    
    
    @IBAction func deleteBtnPressed(_ sender: UIButton) {
        print("deletePressed")
        delegate?.sendString(tagLabel.text!)
    }
    
    
    
    func setData(_ indexPath : IndexPath,_ data : [String]){
        
        tagView.makeCornerRound(radius: 10)
        
        tagLabel.text = data[indexPath.row]
    }
    
}
