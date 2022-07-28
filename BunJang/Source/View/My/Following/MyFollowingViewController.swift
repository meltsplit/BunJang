//
//  MyFollowingViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/28.
//

import UIKit

class MyFollowingViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var followingCollectionView: UICollectionView!
    
    
    //MARK: - Properties
    
    var follwingData : [MyFollowingResult] = []
    
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
        getFollowingUser()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNavBar()
        showTabBar()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        followingCollectionView.delegate = self
        followingCollectionView.dataSource = self
    }
    
    private func setUI(){
        true
    }
    
    private func getFollowingUser(){
        MyFollowingManager.shared.getFollowing { response in
            switch response {
            
            case .success(let data) :
                
                let responseData = data as! MyFollowingResponse
                
                self.setFollowing(responseData.result)
                
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
    
    
    private func setFollowing(_ data : [MyFollowingResult]){
        
        follwingData = data
        followingCollectionView.reloadData()
    }
    
    //MARK: - IBAction
    @IBAction func backBtnPressed(_ sender: Any) {
        popVC()
    }
    
}

extension MyFollowingViewController :UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        follwingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowingCollectionViewCell.cellIdentifier, for: indexPath) as! FollowingCollectionViewCell
        cell.setData(follwingData[indexPath.row])
        return cell
    }
}
extension MyFollowingViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0 )
    }
}

