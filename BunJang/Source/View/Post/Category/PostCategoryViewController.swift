//
//  PostCategoryViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import UIKit

class PostCategoryViewController : BaseViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    //MARK: - Properties
    
    var categoryCount : Int = 1
    var firstCategoryData : [FirstCategoryResult] = [FirstCategoryResult(firstCategoryId: 1, firstCategory: "신발", categoryImgUrl: "https://kuku-keke.com/wp-content/uploads/2020/04/2514_5.png") ]
    var selectCategoryId = FirstCategory.신발
    var selectCategoryName = "신발"
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        getCategory()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
    }
    
    private func setUI(){
        categoryTableView.separatorStyle = .none
    }
    
    private func getCategory(){
        FirstCategoryManager.shared.getFirstCategory { (response) in
            switch response{
            case .success(let data) :
                
                self.setFirstCategory(data as! FirstCategoryResponse)
                
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
    
    private func setFirstCategory(_ data : FirstCategoryResponse ){
        categoryCount = data.result.count
        firstCategoryData = data.result
        categoryTableView.reloadData()
        
    }
    
    
    //MARK: - IBAction
    @IBAction func backBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - TableView Delegate

extension PostCategoryViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.cellIdentifier, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell()}
        
        cell.selectionStyle = .none
        cell.firstCategoryDelegate = self
        cell.setData(indexPath, firstCategoryData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondCategoryVC = UIStoryboard(name: "Post", bundle: nil).instantiateViewController(withIdentifier: "SecondCategoryViewController") as! SecondCategoryViewController
        
        secondCategoryVC.selectedFirstCategoryId = selectCategoryId
        secondCategoryVC.selectedFirstCategoryName = selectCategoryName
        pushVC(secondCategoryVC)
        
        //navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}

extension PostCategoryViewController : FirstCategoryDelegate{
    
    func sendFirstCategory(_ data: FirstCategoryResult) {
        selectCategoryId = FirstCategory(rawValue: data.firstCategoryId)!
        selectCategoryName = data.firstCategory
    }
    
    
}

