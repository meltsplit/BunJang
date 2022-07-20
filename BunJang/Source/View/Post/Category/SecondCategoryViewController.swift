//
//  SecondCategoryViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/19.
//

import UIKit

class SecondCategoryViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var secondCategoryTableView: UITableView!
    @IBOutlet weak var selectedFirstCategoryLabel: UILabel!
    
    //MARK: - Properties
    
    var selectedFirstCategoryId = FirstCategory.신발
    var selectedFirstCategoryName = "스니커즈"
    var selectSecondCategoryId = SecondCategory.스니커즈
    
    var categoryCount = 1
    var secondCategoryData = [SecondCategoryResult(firstCategoryId: 1, lastCategoryId: 1, lastCategory: "11")]
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        getCategory()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavBar()
        hideTabBar()
        
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        showNavBar()
        showTabBar()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        secondCategoryTableView.delegate = self
        secondCategoryTableView.dataSource = self
    }
    
    private func setUI(){
        secondCategoryTableView.separatorStyle = .none
        selectedFirstCategoryLabel.text = selectedFirstCategoryName
    }
    
    private func getCategory(){
        SecondCategoryManager.shared.getSecondCategory(selectedFirstCategoryId) { (response) in
            switch response{
            case .success(let data) :
                
                self.setSecondCategory(data as! SecondCategoryResponse)
                
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
            }
        }
    }
    
    private func setSecondCategory(_ data : SecondCategoryResponse ){
        
        categoryCount = data.result.count
        secondCategoryData = data.result
        
        secondCategoryTableView.reloadData()
        
    }
    
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        popVC()
    }
}

extension SecondCategoryViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.cellIdentifier, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell()}
        
        cell.selectionStyle = .none
        cell.secondCategoryDelegate = self
        cell.setData(indexPath, secondCategoryData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    
    
}

extension SecondCategoryViewController : SecondCategoryDelegate{
    func sendSecondCategory(_ data: SecondCategoryResult) {
        true
    }
    
    
    
}



