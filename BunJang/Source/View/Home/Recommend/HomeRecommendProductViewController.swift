//
//  RecommendProductViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import UIKit

class HomeRecommendProductViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    //MARK: - Properties
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setBar()
        setUI()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }
    
    private func setBar(){
        true
    }
    
    private func setUI(){
        true
    }
    
    
    //MARK: - IBAction
    
}

//MARK: - CollectionView Delegate, DataSource
extension HomeRecommendProductViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ProductModel.sampleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendProductCollectionViewCell.cellIdentifier, for: indexPath) as? RecommendProductCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(ProductModel.sampleData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("셀 선택됨")
        let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        productVC.productId = 1
        navigationController?.pushViewController(productVC, animated: true)
    }
}

//MARK: - CollectionView Delegate FlowLayout
extension HomeRecommendProductViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    //행간 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2 - 7
        let height = width * 2.2
        let size = CGSize(width: width, height: height)
        
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    
}



