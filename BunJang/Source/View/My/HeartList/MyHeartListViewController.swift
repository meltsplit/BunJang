//
//  MyHeartListViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/28.
//

import Foundation
import UIKit

class MyHeartListViewController : BaseViewController {
    
    //MARK: - IBOutlet
    
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    //MARK: - Properties
    
    var productsData : [HeartListResult] = []
    
    var collectionViewWidth = (Device.width - 20) / 2 - 5
    lazy var collectionViewCellHeight = collectionViewWidth * 1.8
    var collectionViewLineSpacing = 10
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavBar()
        hideTabBar()
        
        getMyHeartList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNavBar()
        showTabBar()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        
        let productXib = UINib(nibName: String(describing: ProductsCollectionViewCell.self), bundle: nil)
        
        productCollectionView.register(productXib, forCellWithReuseIdentifier: ProductsCollectionViewCell.cellIdentifier)
        
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }
    
    private func setUI(){
        true
    }
    
    private func getMyHeartList(){
        HeartListManager.shared.getHeartList { response in
            switch response {
            
            case .success(let data) :
                
                let responseData = data as! HeartListResponse
                
                self.setProducts(responseData.result)
                
            case .requestErr(let msg):
                print("요청에러")
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .decodeErr:
                print("decodeError")
            }
        }
    }
    
    private func setProducts(_ data : [HeartListResult]){
        productsData = data
        productCollectionView.reloadData()
    }
    
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        popVC()
    }
}

extension MyHeartListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.cellIdentifier, for: indexPath) as! ProductsCollectionViewCell
        
        cell.setData(productsData[indexPath.row])
        return cell
        
    }
}

extension MyHeartListViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(collectionViewLineSpacing)
    }
    
    //행간 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionViewWidth, height: collectionViewCellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
}

