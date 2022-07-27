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
    
    
    @IBOutlet weak var userProductCountLabel: UILabel!
    @IBOutlet weak var userTotalReviewCountLabel: UILabel!
    
    @IBOutlet weak var userTotalReviewTableView: UITableView!
    @IBOutlet weak var userProductsCollectionView: UICollectionView!
    
    
    
    //MARK: - Properties
    
    var productId : Int?
    var userID : Int?
    var myProduct : Bool = false
    var prevHome = false
    
    var condition : Condition = Condition.sell
    
    var productData : ProductGetResult?
    var userProductsData : [UserProductGetResult] = []
    var totalReviewData : [TotalReviewResult] = []
    var productImageList : [AlamofireSource] = []
    
    var collectionViewWidth = ( Device.width - 40 ) / 3 - 10
    lazy var collectionViewCellHeight = collectionViewWidth * 2.0
    var collectionViewLineSpacing : CGFloat = 5
    
    let productImageCountView : UIView = {
       let view = UIView()
        view.backgroundColor = .darkGray
        view.alpha = 0.5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        setImageSlide()
        if ( userID == Int(User.shared.userId) ) { myProduct = true; setMyProductUI()} else { myProduct = false}
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
        hideTabBar()
        
        getProduct()
        getUserProducts()
        getTotalReview()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavBar()
        showTabBar()
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        
        let productXib = UINib(nibName: String(describing: ProductsCollectionViewCell.self), bundle: nil)
        userProductsCollectionView.register(productXib, forCellWithReuseIdentifier: ProductsCollectionViewCell.cellIdentifier)
        
        userTotalReviewTableView.delegate = self
        userTotalReviewTableView.dataSource = self
        userProductsCollectionView.delegate = self
        userProductsCollectionView.dataSource = self
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
    
    private func setImageSlide(){
        let labelIndicator = LabelPageIndicator()
        labelIndicator.textColor = .white
        
        productImageSlide.pageIndicator = labelIndicator
        
        productImageSlide.addSubview(productImageCountView)
        productImageSlide.bringSubviewToFront(labelIndicator)
        productImageCountView.snp.makeConstraints {
            $0.center.equalTo(labelIndicator.snp.center)
            $0.width.equalTo(labelIndicator).offset(10)
            $0.height.equalTo(labelIndicator).offset(18)
        }
        productImageSlide.pageIndicatorPosition = .init(horizontal: .right(padding: 20), vertical: .customBottom(padding: 20))
        
        
        productImageSlide.contentMode = .scaleAspectFill
    }
    
    func setMyProductUI(){
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
        
    }
    
        
       
    func setProduct(_ data: ProductGetResult){
        
        print("상품 조회 ")
        print("UserID는 : \(data.userId)")
        print("상품 ID는 : \(data.productId)")
        
        productData = data
        productImageList = []
        
        
        if data.productImgs.count == 1 {
            productImageCountView.isHidden = true
        }
        
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
        
        if !myProduct{
            if data.heart{
                wishBtn.isSelected = true
                wishBtn.tintColor = Color.Red
                // TODO: 찜 API
            } else{
                wishBtn.isSelected = false
                wishBtn.tintColor = .lightGray
            }
        }
        
        
        
        self.categoryImageView.image = Image.cloth
        self.categoryImageView.load(urlString: data.lastCategoryImgUrl)
        self.categoryLabel.text = data.lastCategory
        var i = 0
        
        for tagView in tagViewList{
            let count = data.tags.count
            if ( i+1 <= count ){
                self.tagLabelList[i].text = "#\(data.tags[i].tagContents)"
                
            } else{
                tagView.removeFromSuperview()
            }
            i = i + 1
        }
        
        self.profileImageView.load(urlString: data.profileImgUrl)
        self.nicknameLabel.text = data.nickname
        self.starLabel.text = String(data.star)
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
    
    
    
    func setUserProduct(_ data : [UserProductGetResult]){
        userProductCountLabel.text = String(data.count)
        userProductsData = data
        userProductsCollectionView.reloadData()
        
    }
    
    
    func setTotalReview(_ data : [TotalReviewResult]){
        userTotalReviewCountLabel.text = String(data.count)
        totalReviewData = data
        userTotalReviewTableView.reloadData()
    }
    
    
    func resizeCollectionView(){

        var height = 0
        if userProductsData.count > 3 {
            print(collectionViewCellHeight)
            height = Int(collectionViewCellHeight * 2 + collectionViewLineSpacing * 2)} else { height = Int(collectionViewCellHeight + collectionViewLineSpacing) }
        print(height)
        userProductsCollectionView.snp.remakeConstraints {
            $0.height.equalTo(height)
        }
    }
    
    func resizeTableView(){
        var height = 120
        switch totalReviewData.count{
        case 0 : break
        case 1: break
        case 2: height = height * 2
        case 3: height = height * 3
        default: height = height * 3
        }
        
        userTotalReviewTableView.snp.remakeConstraints {
            $0.height.equalTo(height)
        }
    }
    
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        if prevHome{
            dismissLeftToRight()
        } else{
            popVC()
            
        }
    }
    
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
        let userProductVC = UIStoryboard(name: "ShowProduct", bundle: nil).instantiateViewController(withIdentifier: "ShowProductViewController") as! ShowProductViewController
        userProductVC.prevTab = false
        userProductVC.show = Show.userProduct
        userProductVC.userId = userID
        userProductVC.nickname = productData!.nickname
        pushVC(userProductVC)
    }
    
    @IBAction func showTotalCommentBtnPressed(_ sender: UIButton) {
        let totalReviewVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "TotalReviewViewController") as! TotalReviewViewController
        totalReviewVC.productUserId = productData?.userId
        pushVC(totalReviewVC)
        
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
       
        
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        let searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchMainViewController") as! SearchMainViewController
        searchVC.prevTab = false
        pushVC(searchVC)
    }
    
    
    @IBAction func talkBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func purchaseBtnPressed(_ sender: UIButton) {
        
    }
    
    @objc func changeProductBtnPressed(){
        
        var changeProductVC = UIStoryboard(name: "Post", bundle: nil).instantiateViewController(withIdentifier: "PostMainViewController") as! PostMainViewController
        
        productData?.productImgs.forEach({ changeProductVC.imagesData.append($0.productImgUrl) })
        
        changeProductVC.titleData = productData?.title
        changeProductVC.categoryData = SecondCategoryResult(firstCategory: productData!.firstCategory, firstCategoryId: productData!.firstCategoryId, firstCategoryImgUrl: productData!.firstCategoryImgUrl, lastCategory: productData!.lastCategory, lastCategoryId: productData!.lastCategoryId, lastCategoryImgUrl: productData!.firstCategoryImgUrl)
//        
        productData?.tags.forEach({ changeProductVC.tagData.append($0.tagContents) })
        
        changeProductVC.isPatch = true
        changeProductVC.priceData = productData?.price
        changeProductVC.contentsData = productData?.contents
        
        changeProductVC.modalPresentationStyle = .overFullScreen
        
        
        present(changeProductVC, animated: true)
        
        
        
    }
    
    @objc func changeConditionBtnPressed(){
        
    }
    
    @objc func wishedListBtnPressed(){
       
    }
    
    @objc func deleteBtnPressed(){
        
    }
}

