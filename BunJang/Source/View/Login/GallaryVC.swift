//
//  GallaryVC.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/29.
//

import Foundation
import UIKit

class GallayVC : BaseViewController{
    
    //MARK: - IBOutlet
    @IBOutlet weak var gallaryCollectionView: UICollectionView!
    
    //MARK: - Properties
    
    var gallaryData : [GallaryResult] = []
    var delegate : StringDelegate?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        getGallary()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavBar()
        hideTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNavBar()
        showTabBar()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        gallaryCollectionView.delegate = self
        gallaryCollectionView.dataSource = self
    }
    
    private func setUI(){
        true
    }
    
    
    func getGallary(){
        GallaryManager.shared.getGallary { response in
            switch response {
                        case .success(let data) :
                            let responseData = data as! GallaryResponse
                self.setGallary(responseData.result)
                            
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
    
    func setGallary(_ data : [GallaryResult]){
        gallaryData = data
        gallaryCollectionView.reloadData()
    }
    
    //MARK: - IBAction
    
}

extension GallayVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gallaryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GallaryCollectionViewCell.cellIdentifier, for: indexPath) as! GallaryCollectionViewCell
        
        cell.setData(gallaryData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.sendString(gallaryData[indexPath.row].galleryImgUrl)
        dismiss(animated: true)
    }
    
}

extension GallayVC : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    //행간 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (Device.width - 40) / 3 - 9 , height: (Device.width - 40) / 3 - 9)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    
}
