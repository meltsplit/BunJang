//
//  HomeTotalCategoryTabManViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/20.
//

import UIKit
import Tabman
import Pageboy

class HomeTotalMenuTabmanViewController : TabmanViewController{
    
    //MARK: - Properties
    
    private let categoryVC = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "TotalMenuCategoryVC") as! TotalMenuCategoryVC
    private let brandVC = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "TotalMenuBrandVC") as! TotalMenuBrandVC
    private let serviceVC = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "TotalMenuServiceVC") as! TotalMenuServiceVC

    private lazy var viewControllers : Array<UIViewController> = [categoryVC,brandVC,serviceVC]
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setBar()
        setNotification()
        
    }
    
    //MARK: - Custom Method
    
    
    private func setDelegate(){
        self.dataSource = self
    }
    
    private func setBar(){
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.backgroundView.style = .flat(color: .white)
        
        bar.buttons.customize { (button) in
            button.tintColor = .lightGray
            button.selectedTintColor = .black
        }
        
        bar.indicator.weight = .custom(value: 2.8)
        bar.indicator.tintColor = .black
        bar.indicator.overscrollBehavior = .compress
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        // 버튼 사이 간격
           
        addBar(bar, dataSource: self, at: .top)
    }
    
    private func setNotification(){

    }
    
}

extension HomeTotalMenuTabmanViewController : PageboyViewControllerDataSource, TMBarDataSource{
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "카테고리")
        case 1:
            return TMBarItem(title: "브랜드")
        case 2:
            return TMBarItem(title: "서비스")
            
        default:
            let title = "Page\(index)"
            return TMBarItem(title: title)
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        print(viewControllers.count)
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
    
    
    
}

