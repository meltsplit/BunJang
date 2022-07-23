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
    
    @IBOutlet weak var eventView: UIView!
    
    @IBOutlet weak var isUsedLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var shippingFeeLabel: UILabel!
    @IBOutlet weak var changeableLabel: UILabel!
    
    @IBOutlet weak var contentsLabel: UILabel!
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet var tagViewList: [UIView]!
    @IBOutlet var tagLabelList: [UILabel]!
    
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var showTotalProductBtn: UIButton!
    @IBOutlet weak var showTotalReviewBtn: UIButton!
    
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var payStackView: UIStackView!
    @IBOutlet weak var wishBtn: UIButton!
    @IBOutlet weak var talkBtn: UIButton!
    @IBOutlet weak var purchaseBtn: UIButton!
    
    
    //MARK: - Properties
    
    var productId : Int?
    var userID : Int?
    var myProduct : Bool?
    
    var productData : ProductGetResult?
    
    var productImageList : [AlamofireSource] = []
    var testImageList = [AlamofireSource(urlString: "https://image.msscdn.net/images/goods_img/20191105/1214164/1214164_8_500.jpg?t=20220311170314")]
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        if ( userID == Int(User.shared.userId) ) { myProduct = true; setMyProductUI()} else { myProduct = false}
        
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
        
        showTabBar()
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        true
    }
    
    
    private func setUI(){
        wishBtn.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .selected)
        wishBtn.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        
        eventView.makeCornerRound(radius: 10)
        eventView.makeBorder(width: 1, color: .systemGray5)
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
        
        categoryView.makeBorder(width: 1, color: .systemGray5)
        categoryView.makeCornerRound(radius: 10)
        tagViewList.forEach { $0.makeCornerRound(radius: 10); $0.makeBorder(width: 1, color: .systemGray5)
        
            
        }
    }
    
    private func setMyProductUI(){
        followBtn.isHidden = true
        
        payView.snp.remakeConstraints {
            $0.height.equalTo(80)
        }
        
        let changeBtn = makeButton(systemImage: "square.and.pencil", title: "상품수정",
                                   target: #selector(changeProductBtnPressed))
        let conditionChangeBtn = makeButton(systemImage: "goforward", title: "상태변경",
                                            target: #selector(changeConditionBtnPressed))
        let heartedBtn = makeButton(systemImage: "heart", title: "찜한사람",
                                    target: #selector(wishedListBtnPressed))
        let deleteBtn = makeButton(systemImage: "trash", title: "삭제",
                                   target: #selector(deleteBtnPressed))
        
        payStackView.removeAllArrangedSubviews()
        payStackView.addArrangedSubViews([changeBtn,conditionChangeBtn,heartedBtn,deleteBtn])
        
        //talkBtn.set
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
        
        productData = data
        productImageList = []
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
        
        self.categoryImageView.image = Image.cloth
        //self.categoryImageView.load(urlString: data.lastCategoryImgUrl)
        self.categoryLabel.text = data.lastCategory
        var i = 0
        for tagView in tagViewList{
            let count = data.tags.count
            if ( i+1 <= count ){
                print("i : \(i) count: \(count)")
                self.tagLabelList[i].text = "#\(data.tags[i].tagContents)"
                
            } else{
                tagView.removeFromSuperview()
            }
            i = i + 1
        }
        
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
    
    private func postHeart(){
        HeartPostManager.shared.pressHeart(productId: productId!, status: wishBtn.isSelected) { (response) in
            switch response {

            case .success(let data) :
                let responseData = data as! HeartPostResponse
            case .requestErr(let msg):
                self.presentBottomAlert(message: msg as! String)
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
        
        wishBtn.isSelected = !wishBtn.isSelected
        if wishBtn.isSelected{
            wishBtn.tintColor = Color.Red
            // TODO: 찜 API
        } else{
            wishBtn.tintColor = .lightGray
        }
        print("isSelected \(wishBtn.isSelected)")
        postHeart()
        getProduct()
        
    }
    
    @IBAction func talkBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func purchaseBtnPressed(_ sender: UIButton) {
        
    }
    
    @objc func changeProductBtnPressed(){
        
        var changeProductVC = UIStoryboard(name: "Post", bundle: nil).instantiateViewController(withIdentifier: "PostMainViewController") as! PostMainViewController
        
        productData?.productImgs.forEach({ changeProductVC.imagesData.append($0.productImgUrl) })
        
        changeProductVC.titleData = productData?.title
//        changeProductVC.categoryData = SecondCategoryResult(firstCategory: productData!.firstCategory, firstCategoryId: productData!.firstCategoryId, firstCategoryImgUrl: productData!.firstCategoryImgUrl, lastCategory: productData!.lastCategory, lastCategoryId: productData!.lastCategoryId, lastCategoryImgUrl: productData!.firstCategoryImgUrl)
//        
        productData?.tags.forEach({ changeProductVC.tagData.append($0.tagContents) })
        
        changeProductVC.isPatch = true
        changeProductVC.priceData = productData?.price
        changeProductVC.contentsData = productData?.contents
        
        changeProductVC.modalPresentationStyle = .fullScreen
        
        
        present(changeProductVC, animated: true)
        
        
        
    }
    
    @objc func changeConditionBtnPressed(){
        
    }
    
    @objc func wishedListBtnPressed(){
       
    }
    
    @objc func deleteBtnPressed(){
        
    }
}

extension ProductViewController {
    
}

