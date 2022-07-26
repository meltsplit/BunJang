//
//  ShowProductViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/25.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

class ShowProductViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var categoryLine: UIView!
    @IBOutlet weak var lastCategoryCollectionView: UICollectionView!
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    
    
    //MARK: - Properties
    var prevTab = true
    var isCategory = true
    var isLastCategory = true
    
    var categoryId : Int?
    var page = 0
    
    var secondCategoryData : [SecondCategoryResult] = []
    var productsData : [ProductGetResult] = []
    
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
        
        
        if isCategory{
            
            if isLastCategory {
                print("라스트 카테고리 상품 조회입니다잉")
                    lastCategoryCollectionView.isHidden = true
                categoryLine.isHidden = true
            } else {
                print("첫번째 카테고리 상품 조회입니다잉")
                getCategory()
            }
            
            getCategoryProducts()
        } else {
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
        if isLastCategory{
            categoryNameLabel.text = data[0].lastCategory
            categoryImageView.load(urlString: data[0].lastCategoryImgUrl)
        }else{
            categoryNameLabel.text = data[0].firstCategory
            categoryImageView.load(urlString: data[0].firstCategoryImgUrl)
        }
        
        productsData.append(contentsOf: data)
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
        productCollectionView.snp.remakeConstraints {
            $0.height.equalTo((Int(collectionViewCellHeight) + Int(collectionViewLineSpacing)) * (productsData.count+2) / 3)
        }
    }
    
    func reloadPage(){
        if (productsData.count / 6 == page + 1){
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
        
        
        let bottomSheet = MDCBottomSheetController(contentViewController: filterBS)
        present(bottomSheet, animated: true, completion: nil)
    }
    
}

extension ShowProductViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch collectionView.tag{
            
        case 0: return secondCategoryData.count
        case 1: return productsData.count
        default: return 0
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
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
        switch collectionView.tag{
        case 0:
            let categoryProductVC = UIStoryboard(name: "ShowProduct", bundle: nil).instantiateViewController(withIdentifier: "ShowProductViewController") as! ShowProductViewController
            
            categoryProductVC.prevTab = false
            categoryProductVC.isCategory = true
            categoryProductVC.isLastCategory = true
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
            
        case 0: print("여긴들어오니?>"); return CGSize(width: categoryCVWidth, height: categoryCVHeight)
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






