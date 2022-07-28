//
//  RecommendProductViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import UIKit

class HomeRecommendProductViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    //MARK: - Properties
    
    var recommendProductData : [ProductGetResult] = []
    var page = 0
    
    var collectionViewWidth = (Device.width - 40) / 2 - 5
    lazy var collectionViewCellHeight = collectionViewWidth * 2.0
    var collectionViewLineSpacing = 10
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RecommendVC - ViewDidLoad")
        setDelegate()
        setNotification()
        getRecommendProduct()
        resizeCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("REcommend - viewwillAppaer")
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
    }
    
    private func setNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(getPage), name: NSNotification.Name("getRecommend"), object: nil)
    }
    
    @objc private func getPage(_ notification : Notification){
        if (recommendProductData.count / 6 == page + 1){
            page = page + 1
            getRecommendProduct() //전체 상품 조회 API
        } 
    }
    
    private func getRecommendProduct(){
        RecommendProductManager.shared.getProduct(page: page) { (response) in
            switch response {

            case .success(let data) :
                
                let responseData = data as! RecommendProductResponse
                
                if responseData.isSuccess {
                    self.setRecommendData(responseData.result!)
                    print("추천상품 \(responseData.result!.count)개 받았습니다.")
                } else {
                    self.presentBottomAlert(message: "마지막 상품입니다.")
                }
                
            
                
            case .requestErr(let msg):
                print(msg)
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
    
    private func setRecommendData(_ data: [ProductGetResult]){
        recommendProductData.append(contentsOf: data)
        productCollectionView.reloadData()
        resizeCollectionView()
        
    }
    
    private func resizeCollectionView(){
       //let height = (Int(collectionViewCellHeight) + collectionViewLineSpacing) * ProductModel.sampleData.count / 2
        let height = (Int(collectionViewCellHeight) + collectionViewLineSpacing) * (recommendProductData.count + 1) / 2
        DataCheet.shard.height = height
        NotificationCenter.default.post(name: NSNotification.Name("resize"), object: height)
    }
    
    //MARK: - IBAction
    
}

//MARK: - CollectionView Delegate, DataSource
extension HomeRecommendProductViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //ProductModel.sampleData.count
        return recommendProductData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendProductCollectionViewCell.cellIdentifier, for: indexPath) as? RecommendProductCollectionViewCell else { return UICollectionViewCell() }
        //cell.setData(ProductModel.sampleData[indexPath.row])
        cell.setData(recommendProductData[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("셀 선택됨")
        let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        productVC.userID =  recommendProductData[indexPath.row].userId
        productVC.productId = recommendProductData[indexPath.row].productId
        navigationController?.pushViewController(productVC, animated: true)
    }
}

//MARK: - CollectionView Delegate FlowLayout
extension HomeRecommendProductViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(collectionViewLineSpacing)
    }
    
    //행간 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionViewWidth, height: collectionViewCellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    
}

//MARK: - ScrollView Delegate



