//
//  HomeMainViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit
import ImageSlideshow

class HomeMainViewController : BaseViewController{
    
    //MARK: - IBOutlet
   
    @IBOutlet weak var eventImageSlide: ImageSlideshow!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var contentView: UIView!
    
    //MARK: - Properties
    
    var eventImage : [AlamofireSource] = []
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        getBanner()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        
        let menuXib = UINib(nibName: String(describing: MenuCollectionCell.self), bundle: nil)
        menuCollectionView.register(menuXib, forCellWithReuseIdentifier: MenuCollectionCell.cellIdentifier)
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
    }
    
    
    private func setUI(){
        eventImageSlide.setImageInputs(eventImage)
        contentView.snp.makeConstraints {
            $0.height.equalTo(DataCheet.shard.height)
        }
        
    }
    
    func getBanner(){
        
        BannerManager.shared.getBanner { (response) -> (Void) in
            
            switch response{
                
            case .success(let data) :
                
                self.setBannerData(data as! BannerResponse)
                
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
            case .decodeErr:
                print("decodeError")
            }
        }
    }
    
    private func setBannerData(_ data : BannerResponse){
        
        for bannerData in data.result{
            
            eventImage.append( AlamofireSource(urlString: bannerData.bannerImgUrl!)! )
        }
        eventImageSlide.setImageInputs(eventImage)
    }
    
    
    
       
    //MARK: - IBAction
    
}

//MARK: - CollectionView Delegate, DataSource
extension HomeMainViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionCell.cellIdentifier, for: indexPath) as? MenuCollectionCell else { return UICollectionViewCell() }
        
        cell.setData(indexPath)
        
        return cell
    }
    
    
}

//MARK: - CollectionView Delegate FlowLayout

extension HomeMainViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    
}



