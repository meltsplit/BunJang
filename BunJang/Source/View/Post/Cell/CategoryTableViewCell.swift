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
    
    var firstCategoryResult = Default.firstCategory
    var secondCategoryResult = Default.secondCategory
    
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
