//
//  TotalReviewViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/24.
//

import Foundation
import UIKit

class TotalReviewViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var writeReviewView: UIView!
    
    @IBOutlet weak var writeReviewBtn: UIButton!
    @IBOutlet weak var reviewTableView: UITableView!
    
    //MARK: - Properties
    
    var totalReviewData : [TotalReviewResult] = []
    var productUserId : Int?
    var myReview = false
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        getTotalReview()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavBar()
        hideTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNavBar()
        showTabBar()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
    }
    
    private func setUI(){
        if myReview {
            writeReviewView.isHidden = true
        }
        
        writeReviewBtn.makeCornerRound(radius: 10)
        writeReviewBtn.makeBorder(width: 1, color: .lightGray)
    }
    
    private func getTotalReview(){
        TotalReviewManager.shared.getProduct(productUserId : productUserId! ) { response in
            switch response {
            
            case .success(let data) :
                let responseData = data as! TotalReviewResponse
                self.setTotalReview(responseData.result)
                
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
    
    private func setTotalReview(_ data : [TotalReviewResult]){
        totalReviewData = data
        reviewTableView.reloadData()
    }
    
    //MARK: - IBAction
    @IBAction func backBtnPressed(_ sender: Any) { popVC() }
    
}

extension TotalReviewViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        totalReviewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TotalReviewTableViewCell.cellIdentifier, for: indexPath) as? TotalReviewTableViewCell else { return UITableViewCell()}
        cell.setData(totalReviewData[indexPath.row])
        
        return cell
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
        productVC.productId = totalReviewData[indexPath.row].productId
        productVC.userID = totalReviewData[indexPath.row].userId
        pushVC(productVC)
    }
    
    
    
    
}

extension TotalReviewViewController : ViewControllerDelegate{
    func sendViewController(_ vc: UIViewController) {
        pushVC(vc)
    }
}
