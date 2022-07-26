//
//  ProductVC.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/25.
//

import Foundation
import UIKit

extension ProductViewController :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch totalReviewData.count{
        case 0 : return 0
        case 1: return 1
        case 2: return 2
        case 3: return 3
        default: return 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellIdentifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell()}
        
        cell.setData( totalReviewData[indexPath.row] )
        return cell
    }
    
    
}

extension ProductViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if userProductsData.count <= 6 { return userProductsData.count } else { return 6 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.cellIdentifier, for: indexPath) as? ProductsCollectionViewCell else { return UICollectionViewCell()}
        cell.setData( userProductsData[indexPath.row] )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        productVC.productId = userProductsData[indexPath.row].productId
        productVC.userID = userProductsData[indexPath.row].userId
        pushVC(productVC)
    }
    
    
}

extension ProductViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionViewWidth, height: collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewLineSpacing
    }
}
