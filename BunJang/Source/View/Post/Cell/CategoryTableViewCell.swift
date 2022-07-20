//
//  CategoryTableViewCell.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/19.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    var firstCategoryResult = FirstCategoryResult(firstCategoryId: 1, firstCategory: "신발", categoryImgUrl: Image.categoryDefaultImageURL)
    var secondCategoryResult = SecondCategoryResult(firstCategoryId: 1, lastCategoryId: 1, lastCategory: "스니커즈")
    
    var firstCategoryDelegate : FirstCategoryDelegate?
    var secondCategoryDelegate : SecondCategoryDelegate?
    
    //MARK: - Properties

    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        firstCategoryDelegate?.sendFirstCategory(firstCategoryResult)
        secondCategoryDelegate?.sendSecondCategory(secondCategoryResult)
        
    }
    
     //MARK: - Custom Method
    
    func setData(_ indexPath : IndexPath,_ data : [FirstCategoryResult]){
        categoryLabel.text = data[indexPath.row].firstCategory
        firstCategoryResult = data[indexPath.row]
    }
    
    func setData(_ indexPath : IndexPath,_ data : [SecondCategoryResult]){
        categoryLabel.text = data[indexPath.row].lastCategory
        secondCategoryResult = data[indexPath.row]
    }

}
