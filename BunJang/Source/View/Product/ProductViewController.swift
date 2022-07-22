//
//  ProductViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import UIKit
import ImageSlideshow

class ProductViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var productImageSlide: ImageSlideshow!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var updatedAt: UILabel!
    
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var heartCountLabel: UILabel!
    @IBOutlet weak var chatCountLabel: UILabel!
    
    @IBOutlet weak var isUsedLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var shippingFeeLabel: UILabel!
    @IBOutlet weak var changeableLabel: UILabel!
    
    @IBOutlet weak var contentsLabel: UILabel!
    
    @IBOutlet weak var tagCategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var showTotalProductBtn: UIButton!
    @IBOutlet weak var showTotalReviewBtn: UIButton!
    
    @IBOutlet weak var wishBtn: UIButton!
    @IBOutlet weak var talkBtn: UIButton!
    @IBOutlet weak var purchaseBtn: UIButton!
    
    
    //MARK: - Properties
    
    var productId : Int?
    var productImageList : [AlamofireSource] = []
    var testImageList = [AlamofireSource(urlString: "https://image.msscdn.net/images/goods_img/20191105/1214164/1214164_8_500.jpg?t=20220311170314")]
    
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
        
        if productId != nil{
            getProduct()
        } else{
           presentBottomAlert(message: "불러올 상품이 없습니다.")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNavBar()
        showTabBar()
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        true
    }
    
    
    private func setUI(){
        isUsedLabel.makeCornerRound(radius: 10)
        amountLabel.makeCornerRound(radius: 10)
        shippingFeeLabel.makeCornerRound(radius: 10)
        changeableLabel.makeCornerRound(radius: 10)
        profileImageView.makeCornerRound(radius: 10)
        followBtn.makeCornerRound(radius: 10)
        showTotalProductBtn.makeCornerRound(radius: 10)
        showTotalReviewBtn.makeCornerRound(radius: 10)
        talkBtn.makeCornerRound(radius: 10)
        purchaseBtn.makeCornerRound(radius: 10)
    }
    private func getProduct(){
        
        ProductGetManager.shared.getProduct(productId: productId!) { (response) in
            switch response {
            case .success(let data) :
                let responseData = data as! ProductGetResponse
                self.setProduct(responseData.result)
                
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
            case .pathErr :
                print("pathErr")
            case .decodeErr:
                print("decodeError")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    private func setProduct(_ data: ProductGetResult){
        data.productImgs.forEach { self.productImageList.append( (AlamofireSource(urlString: $0.productImgUrl) ?? AlamofireSource(urlString: Default.defaultImage))! ) }
        productImageSlide.setImageInputs(productImageList)
        self.priceLabel.text = makePriceString(data.price)! + " 원"
        self.titleLabel.text = data.title
        self.locationLabel.text = data.location
        self.updatedAt.text = data.updatedAt
        self.viewCountLabel.text = String(data.viewCnt)
        self.heartCountLabel.text = String(data.heartCnt)
        self.chatCountLabel.text = String(data.chatCnt)
        self.isUsedLabel.text = data.isUsed ? "중고상품" : "새상품"
        self.amountLabel.text = "총 \(String(data.amount))개"
        self.shippingFeeLabel.text = data.shippingFee ? "배송비포함" : "배송비별도"
        self.changeableLabel.text = data.changeable ? "교환가능" : "교환불가"
        self.contentsLabel.text = data.contents
        self.profileImageView.load(urlString: data.profileImgUrl)
        self.nicknameLabel.text = data.nickname
        //self.starLabel.text = String(data.star!)
        self.followerLabel.text = String(data.follower)
        
        if data.follow {
            btnUnSelectedUI(followBtn)
            followBtn.setTitle("팔로잉", for: .normal)
        } else{
            btnSelectedUI(followBtn)
            followBtn.setTitle("팔로우", for: .normal)
        }
        
        for image in self.productImageSlide.slideshowItems {
            image.imageView.contentMode = .scaleAspectFill
        }
                                                              
        
    }
    
    
    //MARK: - IBAction
    @IBAction func backBtnPressed(_ sender: UIButton) { popVC() }
    
    @IBAction func followBtnPressed(_ sender: UIButton) {
        followBtn.isSelected = !followBtn.isSelected
        if followBtn.isSelected{
            btnSelectedUI(followBtn)
            followBtn.setTitle("팔로우", for: .normal)
        }else{
            btnUnSelectedUI(followBtn)
            followBtn.setTitle("팔로잉", for: .normal)
        }
    }
    
    @IBAction func showTotalProductBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func showTotalCommentBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func wishBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func talkBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func purchaseBtnPressed(_ sender: UIButton) {
    }
}

extension ProductViewController {
    
}

