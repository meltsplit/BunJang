//
//  ShowProductViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/25.
//

import UIKit
import MaterialComponents.MaterialBottomSheet
import SnapKit
class ShowProductViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var whichCategoryLabel: UILabel!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var categoryLine: UIView!
    @IBOutlet weak var lastCategoryCollectionView: UICollectionView!
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    
    
    //MARK: - Properties
    var prevTab = true
    var filter : Filter = Filter.recent
    var userId : Int?
    var show : Show = Show.userProduct
    var isLastCategory = false
    var categoryId : Int?
    var page = 0
    
    var secondCategoryData : [SecondCategoryResult] = []
    var productsData : [ProductGetResult] = []
    var userProductsData : [UserProductGetResult] = []
    
    var categoryCVWidth : CGFloat = (Device.width - 40) / 2 - 10
    lazy var categoryCVHeight : CGFloat = 30
    
    var collectionViewWidth = (Device.width - 40) / 3 - 10
    lazy var collectionViewCellHeight = collectionViewWidth * 2
    var collectionViewLineSpacing : CGFloat = 5
    
    
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
        
        switch show {
        case .userProduct:
            
            lastCategoryCollectionView.isHidden = true
            categoryStackView.isHidden = true
            getUserProducts()
            userLabel.text = "\(userId)님의 상품"
            filterStackView.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(20)
            }
        case .firstCategoryProduct:
            
            print("첫번째 카테고리 상품 조회입니다잉")
            getCategory()
            getCategoryProducts()
            
        case .lastCategoryProduct:
            isLastCategory = true
            whichCategoryLabel.text = "하위 카테고리"
            print("라스트 카테고리 상품 조회입니다잉")
            lastCategoryCollectionView.isHidden = true
            categoryLine.isHidden = true
            getCategoryProducts()
            
        case .keywordProduct:
            print("키워드 검색 상품 조회입니다잉")
            getKeywordProducts()
        }
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNavBar()
        showTabBar()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        mainScrollView.delegate = self
        
        lastCategoryCollectionView.delegate = self
        lastCategoryCollectionView.dataSource = self
        
        let productXib = UINib(nibName: String(describing: ProductsCollectionViewCell.self), bundle: nil)
        productCollectionView.register(productXib, forCellWithReuseIdentifier: ProductsCollectionViewCell.cellIdentifier)
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }
    
    private func setUI(){
        categoryImageView.makeCornerRound(radius: 2)
        categoryImageView.makeBorder(width: 1, color: .systemGray5)
    }
    
    func setCategory(_ data : [SecondCategoryResult]){
        secondCategoryData = data
        lastCategoryCollectionView.reloadData()
        resizeCategoryCollectionView()
        
    }
    func setCategoryProduct(_ data : [ProductGetResult]){
        
        switch show {
        case .userProduct:
            print("유저 상품입니당")
        case .firstCategoryProduct:
            categoryNameLabel.text = data[0].firstCategory
            categoryImageView.load(urlString: data[0].firstCategoryImgUrl)
        case .lastCategoryProduct:
            categoryNameLabel.text = data[0].lastCategory
            categoryImageView.load(urlString: data[0].lastCategoryImgUrl)
        case .keywordProduct:
            print("키워드입니당")
        }
        
        productsData.append(contentsOf: data)
        productCollectionView.reloadData()
        resizeProductsCollectionView()
    }
    
    func setCategoryProduct(_ data : [UserProductGetResult]){
        
        userProductsData.append(contentsOf: data)
        productCollectionView.reloadData()
        resizeProductsCollectionView()
    }
    
    
    func resizeCategoryCollectionView(){
        lastCategoryCollectionView.snp.remakeConstraints {
            let height = (Int(categoryCVHeight) + Int(collectionViewLineSpacing)) * (secondCategoryData.count+1) / 2
            
            $0.height.equalTo(   height )
        }
    }
    func resizeProductsCollectionView(){
        if show == Show.userProduct{
            productCollectionView.snp.remakeConstraints {
                $0.height.equalTo((Int(collectionViewCellHeight) + Int(collectionViewLineSpacing)) * (userProductsData.count+2) / 3)
            }
        } else {
            productCollectionView.snp.remakeConstraints {
                $0.height.equalTo((Int(collectionViewCellHeight) + Int(collectionViewLineSpacing)) * (productsData.count+2) / 3)
            }
        }
    }
    
    func reloadPage(){
        if (productsData.count / 9 == page + 1){
            page = page + 1
            getCategoryProducts()
        }
    }
    
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        if prevTab {
            
            guard let BaseVC = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarController") as? BaseTabBarController else { return }
            BaseVC.modalPresentationStyle = .fullScreen
            present(BaseVC, animated: false)
            
        } else {
            popVC()
        }
    }
    
    @IBAction func filterBtnPressed(_ sender: UIButton) {
        let filterBS = UIStoryboard(name: "ShowProduct", bundle: nil).instantiateViewController(withIdentifier: "FilterBottomSheet") as! FilterBottomSheet
        filterBS.delegate = self
        filterBS.filter = filter
        let bottomSheet = MDCBottomSheetController(contentViewController: filterBS)
        present(bottomSheet, animated: true, completion: nil)
    }
    
}

extension ShowProductViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if show == Show.userProduct{
            return userProductsData.count
        }
        
        switch collectionView.tag{
            
        case 0: return secondCategoryData.count
        case 1: return productsData.count
        default: return 0
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        
        if show == Show.userProduct{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.cellIdentifier, for: indexPath) as! ProductsCollectionViewCell
            cell.setData(userProductsData[indexPath.row])
            return cell
        }
        
        switch collectionView.tag{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCategoryCollectionViewCell.cellIdentifier, for: indexPath) as! SecondCategoryCollectionViewCell
            cell.setData(secondCategoryData[indexPath.row])
           
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.cellIdentifier, for: indexPath) as! ProductsCollectionViewCell
            cell.setData(productsData[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if show == Show.userProduct{
            let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
            productVC.productId = userProductsData[indexPath.row].productId
            productVC.userID = userProductsData[indexPath.row].userId
            pushVC(productVC)
        }
        
        switch collectionView.tag{
        case 0:
            let categoryProductVC = UIStoryboard(name: "ShowProduct", bundle: nil).instantiateViewController(withIdentifier: "ShowProductViewController") as! ShowProductViewController
            
            categoryProductVC.prevTab = false
            categoryProductVC.show = Show.lastCategoryProduct
            categoryProductVC.categoryId = secondCategoryData[indexPath.row].lastCategoryId
            pushVC(categoryProductVC)
            
        case 1:
            let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
            productVC.productId = productsData[indexPath.row].productId
            productVC.userID = productsData[indexPath.row].userId
            pushVC(productVC)
        default: break
        }
    }
    
}

extension ShowProductViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView.tag{
            
        case 0: return CGSize(width: categoryCVWidth, height: categoryCVHeight)
        case 1: return CGSize(width: collectionViewWidth, height: collectionViewCellHeight)
        default: return CGSize()
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewLineSpacing
    }
}


extension ShowProductViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            if scrollView == mainScrollView{
                reloadPage()
                print("스크롤 밑바닥이여")
            }
        }
        
    }
}

extension ShowProductViewController : FilterDelegate{
    func sendFilter(_ data: Filter) {
        filter = data
        
        productsData = []
        page = 0
        switch show{
        case .userProduct: print("여긴 올일 없음")
        case .firstCategoryProduct:
            
            getCategoryProducts()
            
        case .lastCategoryProduct :
            
            getCategoryProducts()
        case .keywordProduct:
            getKeywordProducts()
        }
        
        switch filter{
        case .recent: filterBtn.setTitle("최신순", for: .normal)
        case .ascend: filterBtn.setTitle("낮은 가격순", for: .normal)
        case .descend: filterBtn.setTitle("높은 가격순", for: .normal)
      
        }
    }
    
    
}






