//
//  MyMainViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit
import SnapKit

class MyMainViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var myProductCollectionView: UICollectionView!
    
    //MARK: - Properties
    
    var myProductData : [MyProductGetResult] = []
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        getMyProduct(condition: Condition.sell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavBar()
        hideTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showNavBar()
        showTabBar()
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        let myXib = UINib(nibName: String(describing: MyProductCollectionViewCell.self), bundle: nil)
        myProductCollectionView.register(myXib, forCellWithReuseIdentifier: MyProductCollectionViewCell.cellIdentifier)
        
        myProductCollectionView.delegate = self
        myProductCollectionView.dataSource = self
        
    }
    
    
    private func setUI(){
        true
    }
    
    private func getMyProduct(condition: Condition){
        MyProductGetManager.shared.getProduct( condition: condition ) { (response) in
            switch response {
            case .success(let data) :
                let responseData = data as! MyProductGetResponse
                self.setMyProduct(responseData.result)
                
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    private func setMyProduct(_ data: [MyProductGetResult]){
        myProductData = data
        print("~~~~~~~~~~~~~~~~~~Reload 할꾸얌~~~~~")
        myProductCollectionView.reloadData()
        
        let width = Device.width - 40
        let height = width / 350 * 120 + 20
        
        myProductCollectionView.snp.makeConstraints {
            $0.height.equalTo(Int(height) * myProductData.count )
        }
    }
    
    //MARK: - IBAction
    
}

//MARK: - CollectionView Delegate, DataSource
extension MyMainViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return myProductData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyProductCollectionViewCell.cellIdentifier, for: indexPath) as? MyProductCollectionViewCell else {return UICollectionViewCell()}
        
        cell.setData(myProductData[indexPath.row])
        return cell
    }
    
}

extension MyMainViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Device.width - 40
        let height = width / 350 * 120
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

