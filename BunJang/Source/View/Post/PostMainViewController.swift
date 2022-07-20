//
//  PostViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/16.
//

import UIKit
import SnapKit
import Then
import MaterialComponents.MaterialBottomSheet

class PostMainViewController : BaseViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var optionSelectBtn: UIButton!
    
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var categoryPlaceHolderLabel: UILabel!

    private var firstCategoryLabel = UILabel().then {
        
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
        $0.setContentHuggingPriority(.init(751), for: .horizontal)
    }
    
    private var rightShift = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40)).then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .systemGray2
        $0.setContentHuggingPriority(.init(rawValue: 751), for: .horizontal)
    }
    
    private var secondCategoryLabel = UILabel().then {
        
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
        
        
    }
    
    private var space = UIView().then {
        $0.backgroundColor = .mainOrange
        $0.setContentHuggingPriority(.init(248), for: .horizontal)
    }
    
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var safePayView: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    
    //MARK: - Properties
    
    var categoryData : SecondCategoryResult?
    var tagData : [String]?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        
        self.dismissKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showNavBar()
        showTabBar()
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        return
    }
    
    private func setBar(){
        hideNavBar()
        hideTabBar()
    }
    
    private func setUI(){
        cameraView.makeCornerRound(radius: 10)
        
        registerView.layer.addBorder([.top], color: UIColor.systemGray5, width: 1)
        
        optionSelectBtn.makeCornerRound(radius: 10)
        optionSelectBtn.makeBorder(width: 1, color: UIColor.systemGray3)
        
       safePayView.makeBorder(width: 2, color: UIColor.systemGray5)
       safePayView.makeCornerRound(radius: 10)
        registerBtn.makeCornerRound(radius: 10)
    }
    
    private func showCategoryLabel(){
        
        categoryPlaceHolderLabel.isHidden = true
        
        firstCategoryLabel.text = categoryData!.firstCategory
        secondCategoryLabel.text = categoryData!.lastCategory
        
        view.addSubview(firstCategoryLabel)
        view.addSubview(rightShift)
        view.addSubview(secondCategoryLabel)
        view.addSubview(space)
        
        categoryStackView.addArrangedSubview(firstCategoryLabel)
        categoryStackView.addArrangedSubview(rightShift)
        categoryStackView.addArrangedSubview(secondCategoryLabel)
    }
    
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Tab", bundle: nil)
        
        guard let BaseVC = storyboard.instantiateViewController(withIdentifier: "BaseTabBarController") as? BaseTabBarController else { return }
        
        BaseVC.modalPresentationStyle = .fullScreen
        present(BaseVC, animated: false)
    }
    
    @IBAction func cameraBtnPressed(_ sender: UITapGestureRecognizer) {
        print("카메라 버튼 클릭")
    }
    
    @IBAction func categoryBtnPressed(_ sender: UITapGestureRecognizer) {
        let categoryVC = UIStoryboard(name: "Post", bundle: nil).instantiateViewController(withIdentifier: "PostCategoryViewController") as! PostCategoryViewController
        
        categoryVC.delegate = self
        pushVC(categoryVC)
    }
    
    @IBAction func tagBtnPressed(_ sender: UITapGestureRecognizer) {
        let tagVC = UIStoryboard(name: "Post", bundle: nil).instantiateViewController(withIdentifier: "PostTagViewController") as! PostTagViewController
        
        tagVC.delegate = self
        pushVC(tagVC)
    }
    
    
    @IBAction func optionBtnPressed(_ sender: UIButton) {
        
        let optionBS = UIStoryboard(name: "Post", bundle: nil).instantiateViewController(withIdentifier: "OptionBottomSheet") as! OptionBottomSheet
        
        optionBS.delegate = self
        let bottomSheet = MDCBottomSheetController(contentViewController: optionBS)
        present(bottomSheet, animated: true, completion: nil)
    }
    
}


extension PostMainViewController : optionDataDelegate,SecondCategoryDelegate,ArrayStringDelegate {
    
    func sendSecondCategory(_ data: SecondCategoryResult) {
        
        //첫번쨰 카테고리 뷰로부터 델리게이트로 데이터 받아옴
        categoryData = data
        showCategoryLabel()
        
        
    }
    
    
    func sendArrayString(_ data: [String]) {
        tagData = data
        print(tagData)
    }
    
    
    
    
    func sendData(_ data: OptionModel) {
        // TODO: data 처리하자 석우야~
        print(data)
    }
    
    
}

