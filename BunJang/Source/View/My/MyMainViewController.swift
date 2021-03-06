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
    
    @IBOutlet var starList: [UIImageView]!
    
    @IBOutlet weak var eventView: UIView!
    
    @IBOutlet weak var heartLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    
    @IBOutlet var conditionBtnList: [UIButton]!
    @IBOutlet var conditionLineViewList: [UIView]!
    
    @IBOutlet weak var productCountLabel: UILabel!
    
    @IBOutlet weak var myProductCollectionView: UICollectionView!
    
    //MARK: - Properties
    
    var collectionViewWidth = Device.width - 40
    lazy var collectionViewCellHeight = collectionViewWidth / 350 * 120
    var collectionViewLineSpacing : CGFloat = 20
    
    var myProductData : [UserProductGetResult] = []
    
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
        print("willappear")
        
        getMyPage()
        getMyProduct(condition: Condition.sell)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showNavBar()
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        let myXib = UINib(nibName: String(describing: MyProductCollectionViewCell.self), bundle: nil)
        myProductCollectionView.register(myXib, forCellWithReuseIdentifier: MyProductCollectionViewCell.cellIdentifier)
        
        myProductCollectionView.delegate = self
        myProductCollectionView.dataSource = self
        
    }
    
    
    private func setUI(){
        profileImageView.makeCornerRound(radius: 2)
        eventView.makeCornerRound(radius: 10)

        for btn in conditionBtnList{
            btn.setTitleColor(.black, for: .selected)
            btn.setTitleColor(.systemGray, for: .normal)
            
            }
        conditionLineViewList[1].snp.remakeConstraints {
            $0.height.equalTo(1)
        }
        conditionLineViewList[2].snp.remakeConstraints {
            $0.height.equalTo(1)
        }
        
    }
    
    private func getMyPage(){
        MyPageManager.shared.getMyPage {
            switch $0 {
            case .success(let data) :
                let response = data as! MyPageResponse
                self.setMyPage(response.result)
                
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
    
    
    private func getMyProduct(condition: Condition){
        UserProductGetManager.shared.getProduct(userID: Int(User.shared.userId)! ,condition: condition ) { (response) in
            switch response {
            case .success(let data) :
                let responseData = data as! UserProductGetResponse
                if responseData.isSuccess{
                    self.setMyProduct(responseData.result!)
                } else{
                    self.presentBottomAlert(message: responseData.message)
                }
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
    
    private func setMyPage(_ data: MyPageResult){

        profileImageView.kfSetImage(urlSting: data.profileImgUrl)
        nicknameLabel.text = data.nickname
        
        for i in 0..<5{
            if(i <= Int(data.star)){
                starList[i].tintColor = Color.Red
            } else {
                starList[i].tintColor = .systemGray2
                
            }
        }
        
        heartLabel.text = String(data.heartCnt)
        reviewLabel.text = String(data.reviewCnt)
        followerLabel.text = String(data.followerCnt)
        followingLabel.text = String(data.followingCnt)
        
        
        
    }
    
    private func setMyProduct(_ data: [UserProductGetResult]){
        myProductData = data
        
        productCountLabel.text = "\(data.count) 개"
        myProductCollectionView.reloadData()
        
        
        myProductCollectionView.snp.remakeConstraints {
            $0.height.equalTo((Int(collectionViewCellHeight) + Int(collectionViewLineSpacing)) * myProductData.count )
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func wishedTapped(_ sender: Any) {
        
        let heartListVC = UIStoryboard(name: "My", bundle: nil).instantiateViewController(withIdentifier: "MyHeartListViewController") as! MyHeartListViewController
        pushVC(heartListVC)
    }
    
    @IBAction func reviewTapped(_ sender: Any) {
        let totalReviewVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "TotalReviewViewController") as! TotalReviewViewController
        totalReviewVC.productUserId = Int(User.shared.userId)
        totalReviewVC.myReview = true
        pushVC(totalReviewVC)
        
    }
    
    @IBAction func followerTapped(_ sender: UITapGestureRecognizer) {
        let followerVC = UIStoryboard(name: "My", bundle: nil).instantiateViewController(withIdentifier: "MyFollowerViewController") as! MyFollowerViewController
        pushVC(followerVC)
    }
    
    @IBAction func followingTapped(_ sender: UITapGestureRecognizer) {
        let followingVC = UIStoryboard(name: "My", bundle: nil).instantiateViewController(withIdentifier: "MyFollowingViewController") as! MyFollowingViewController
        pushVC(followingVC)
    }
    
    
    
    @IBAction func conditionBtnPressed(_ sender: UIButton) {
        
        conditionBtnList.forEach {
            if $0 == sender{
                $0.isSelected = true
                $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .heavy)
                getMyProduct(condition: sender.condition)
                conditionLineViewList[$0.tag].backgroundColor = .black
                conditionLineViewList[$0.tag].snp.remakeConstraints { $0.height.equalTo(2)
                }
        
            } else {
                $0.isSelected = false
                $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
                conditionLineViewList[$0.tag].backgroundColor = .systemGray5
                conditionLineViewList[$0.tag].snp.remakeConstraints { $0.height.equalTo(1)
                    
                }
            }
        }
         
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        
        productVC.userID =  myProductData[indexPath.row].userId
        productVC.productId = myProductData[indexPath.row].productId
        navigationController?.pushViewController(productVC, animated: true)
    }
    
}

extension MyMainViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionViewWidth, height: collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewLineSpacing
    }
}

