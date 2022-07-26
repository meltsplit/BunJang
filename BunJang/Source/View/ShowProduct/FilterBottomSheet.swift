//
//  OptionBottomSheet.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/18.
//

import UIKit



class FilterBottomSheet : BaseViewController {
    
    //MARK: - IBOutlet
   
    @IBOutlet var filterBtnList: [UIButton]!
    @IBOutlet weak var selectBtn: UIButton!
    
    //MARK: - Properties
    
    var filter : Filter = Filter.recent
    var delegate : FilterDelegate?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setFilter()
    }
    
    //MARK: - Custom Method
    
    private func setUI(){
        self.view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner,.layerMaxXMinYCorner)
        view.makeCornerRound(radius: 40)
        
        
        filterBtnList.forEach {
            $0.setTitleColor(Color.Red, for: .selected)
            $0.setTitleColor(UIColor.systemGray2, for: .normal)
            
        }
        
        selectBtn.makeCornerRound(radius: 15)
    }
    
    private func setFilter(){
        
        switch filter {
        case .recent:
            filterBtnList[0].isSelected = true
            filterBtnList[1].isSelected = false
            filterBtnList[2].isSelected = false
            
        
        case .ascend:
            filterBtnList[0].isSelected = false
            filterBtnList[1].isSelected = true
            filterBtnList[2].isSelected = false
        case .descend:
            filterBtnList[0].isSelected = false
            filterBtnList[1].isSelected = false
            filterBtnList[2].isSelected = true
            
        }
        
    }
   
    
    //MARK: - IBAction
    
    @IBAction func filterBtnPressed(_ sender: UIButton) {
        
        for btn in filterBtnList {
                   if btn == sender {
                       btn.isSelected = true
                       filter = btn.filter
                   } else {
                       btn.isSelected = false
                      
                   }
        }
    }
    
    
    
    @IBAction func selectBtnPressed(_ sender: UIButton) {
        delegate?.sendFilter(filter)
        dismiss(animated: true)
    }
    
    
}


