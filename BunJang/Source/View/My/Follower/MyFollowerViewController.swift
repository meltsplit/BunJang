//
//  MyFollowerViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/28.
//

import UIKit

class MyFollowerViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var followerTableView: UITableView!
    
    //MARK: - Properties
    
    var followerData : [MyFollowerResult] = []
    
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
        getFollowerUser()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNavBar()
        showTabBar()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        followerTableView.delegate = self
        followerTableView.dataSource = self
    }
    
    private func setUI(){
        true
    }
    
    private func getFollowerUser(){
        MyFollowerManager.shared.getFollower { response in
            switch response {
            
            case .success(let data) :
                
                let responseData = data as! MyFollowerResponse
                
                self.setFollowing(responseData.result)
                
            case .requestErr(let msg):
                print("요청에러")
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
    
    
    private func setFollowing(_ data : [MyFollowerResult]){
        followerData = data
        followerTableView.reloadData()
    }
    
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: Any) {
        popVC()
    }
}

extension MyFollowerViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowerTableViewCell.cellIdentifier, for: indexPath) as! FollowerTableViewCell
        cell.setData(followerData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let marketVC = tableView.dequeueReusableCell(withIdentifier: "MarketViewController", for: indexPath) as! MarketViewController
        
        marketVC.userId = followerData[indexPath.row].userId
        
        pushVC(marketVC)
     }
    
}

