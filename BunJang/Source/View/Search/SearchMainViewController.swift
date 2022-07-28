//
//  SearchMainViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit

class SearchMainViewController : BaseViewController{
    
    //MARK: - IBOutlet
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var recentSearchCollectoinView: UICollectionView!
    @IBOutlet weak var hotKeywordCollectionView: UICollectionView!
    
    //MARK: - Properties
    
    var prevTab = true
    
    var recentSearchData : [RecentSearchResult] = []
    var hotSearchData : [HotSearchResult] = []
    var searchData : String?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        hideNavBar()
        
        searchTextField.becomeFirstResponder()
        getRecentSearch()
        getHotSearch()
    }
    override func viewWillDisappear(_ animated: Bool) {
        showTabBar()
        showNavBar()
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        searchTextField.delegate = self
        recentSearchCollectoinView.delegate = self
        recentSearchCollectoinView.dataSource = self
        hotKeywordCollectionView.delegate = self
        hotKeywordCollectionView.dataSource = self
        recentSearchCollectoinView.isUserInteractionEnabled = true
        hotKeywordCollectionView.isUserInteractionEnabled = true
    }
    
    private func setUI(){
        if prevTab{
            backBtn.isHidden = true
        }
        searchTextField.addLeftPadding()
        
    }
    
    private func getRecentSearch(){
        RecentSearchManager.shared.getRecentSearch { response in
            switch response {
            
            case .success(let data) :
                let responseData = data as! RecentSearchResponse
                self.setRecentSearch(responseData.result)
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
    
    private func getHotSearch(){
        HotSearchManager.shared.getHotSearch { response in
            switch response {
            
            case .success(let data) :
                let responseData = data as! HotSearchResponse
                self.setHotSearch(responseData.result)
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
    
    private func deleteRecentKeyword(){
        DeleteRecentSearchManager.shared.deleteRecentSearch { response in
            switch response {
            
            case .success(let data) :
                self.deleteKeyword()
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
    
    private func setRecentSearch(_ data : [RecentSearchResult]){
        recentSearchData = data
        recentSearchCollectoinView.reloadData()
        
    }
    
    private func setHotSearch(_ data : [HotSearchResult]){
        hotSearchData = data
        hotKeywordCollectionView.reloadData()
    }
    
    private func deleteKeyword(){
        recentSearchData = []
        recentSearchCollectoinView.reloadData()
    }
    
    private func goProductsView(){
        if searchData != nil {
            let keywordProductVC = UIStoryboard(name: "ShowProduct", bundle: nil).instantiateViewController(withIdentifier: "ShowProductViewController") as! ShowProductViewController
            keywordProductVC.show = Show.keywordProduct
            keywordProductVC.prevTab = false
            keywordProductVC.keyword = searchData
            keywordProductVC.searchText = searchData
            keywordProductVC.prevSearch = true
            print("이걸로 검색할게\(searchData)")
            pushVC(keywordProductVC)
        }
        searchTextField.text = ""
        dismissKeyboard()
        
    }
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        popVC()
        
    }
    
    @IBAction func deleteBtnPressed(_ sender: UIButton) {
        deleteRecentKeyword()
    }
    
}

extension SearchMainViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag{
        case 0: return recentSearchData.count
        case 1: return hotSearchData.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.cellIdentifier, for: indexPath) as! RecentSearchCollectionViewCell
            cell.setData(recentSearchData[indexPath.row])
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSearchCollectionViewCell.cellIdentifier, for: indexPath) as! HotSearchCollectionViewCell
            cell.setData(hotSearchData[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("이거뜨면 태그로유")
        switch collectionView.tag{
        case 0:
            print("선택됐지?")
            searchData = recentSearchData[indexPath.row].keyword
        case 1:
            searchData = hotSearchData[indexPath.row].keyword
        default: return
        }
        
        goProductsView()
    }
  
    
    
}
    
extension SearchMainViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        dismissKeyboardWhenTappedAround()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //removeKeyboardTappedGesture()
        guard let text = textField.text else {return }
        searchData = !text.isEmpty ? text : nil
        goProductsView()
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

