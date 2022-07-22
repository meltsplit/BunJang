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
    
    var delegate : SecondCategoryDelegate?
    
    var selectedFirstCatedoryResult = Default.firstCategory
    
    var selectSecondCategoryResult = Default.secondCategory
    
    var categoryCount = 1
    var secondCategoryData = [ Default.secondCategory]
    
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
        selectedFirstCategoryLabel.text = selectedFirstCatedoryResult.firstCategory
    }
    
    private func getCategory(){
        SecondCategoryManager.shared.getSecondCategory(selectedFirstCatedoryResult.firstCategoryId) { (response) in
            switch response{
            case .success(let data) :
                
                self.setSecondCategory(data as! SecondCategoryResponse)
                
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
            case .pathErr :
                print(" - pathErr")
            case .serverErr :
                print(" - serverErr")
            case .networkFail:
                print(" - networkFail")
            case .decodeErr:
                print("decodeError")
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
        
        //MARK: - 유저가 두번째 카테고리까지 선택시

        popVCNoAnimate()
        delegate?.sendSecondCategory(selectSecondCategoryResult)
        
        
    }
    
    
    
}

extension SecondCategoryViewController : SecondCategoryDelegate{
    func sendSecondCategory(_ data: SecondCategoryResult) {
        selectSecondCategoryResult = data
    }
    
    
    
}



