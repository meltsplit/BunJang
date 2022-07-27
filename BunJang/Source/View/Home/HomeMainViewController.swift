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
    
    @IBOutlet weak var homeScrollView: UIScrollView!
    @IBOutlet weak var eventImageSlide: ImageSlideshow!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var contentView: UIView!
    
    //MARK: - Properties
    
    var eventImage : [AlamofireSource] = []
    var page = 0
    
    
    let bannerCountView : UIView = {
           let view = UIView()
        view.backgroundColor = .darkGray
        view.alpha = 0.3
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataCheet.shard.height = 350
        setNotificationCenter()
        setDelegate()
        setUI()
        showTabBar()
        setImageSlide()
        getBanner()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("home - ViewWillAppear")
        
        if DataCheet.shard.prevPost{
            DataCheet.shard.prevPost = false
            goProductVC()
        }
        
        
    }
    
    //MARK: - Custom Method
    
    
    private func setDelegate(){
        
        let menuXib = UINib(nibName: String(describing: MenuCollectionCell.self), bundle: nil)
        menuCollectionView.register(menuXib, forCellWithReuseIdentifier: MenuCollectionCell.cellIdentifier)
        
        homeScrollView.delegate = self
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
    }
    
    private func setImageSlide(){
        let labelIndicator = LabelPageIndicator()
        labelIndicator.textColor = .white
        
        eventImageSlide.pageIndicator = labelIndicator
        
        eventImageSlide.addSubview(bannerCountView)
        eventImageSlide.bringSubviewToFront(labelIndicator)
        bannerCountView.snp.makeConstraints {
            $0.center.equalTo(labelIndicator.snp.center)
            $0.width.equalTo(labelIndicator).offset(7)
            $0.height.equalTo(labelIndicator).offset(18)
        }
        eventImageSlide.pageIndicatorPosition = .init(horizontal: .right(padding: 20), vertical: .customBottom(padding: 20))
        
        eventImageSlide.setImageInputs(eventImage)
        eventImageSlide.contentMode = .scaleAspectFill
    }
    
    private func setUI(){
        
        
        resizeScrollViewContents()
        
    }
    
    private func setNotificationCenter(){
        
        print("Notification Observer 가동 시작")
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataReceived), name: NSNotification.Name("resize"), object: nil)
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
    
    @objc func dataReceived(_ notification: Notification) {
            
            resizeScrollViewContents()
            
        }
    
    func resizeScrollViewContents(){
        
        contentView.snp.remakeConstraints {
            $0.height.equalTo(DataCheet.shard.height)
        }
        
    }
    
    private func goProductVC(){
        print("goProductVC()")
        let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        
        productVC.userID = Int(User.shared.userId)
        productVC.productId = DataCheet.shard.productId
        productVC.prevHome = true
        productVC.modalPresentationStyle = .overFullScreen
        present(productVC, animated: true)
    }
    
    
    
       
    //MARK: - IBAction
    @IBAction func searchBtnPressed(_ sender: Any) {
        let searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchMainViewController") as! SearchMainViewController
        searchVC.prevTab = false
        pushVC(searchVC)
    }
    
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

extension HomeMainViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == homeScrollView{
            if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                NotificationCenter.default.post(name: NSNotification.Name("getRecommend"), object: page)
            }
        }
    }
}




