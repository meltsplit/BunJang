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
import Alamofire

class PostMainViewController : BaseViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleLine: UIView!
    
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var categoryPlaceHolderLabel: UILabel!

    @IBOutlet weak var tagStackView: UIStackView!
    @IBOutlet weak var tagPlaceHolderLabel: UILabel!
    
    
    @IBOutlet weak var wonLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var priceLine: UIView!
    @IBOutlet weak var shippingFeeBtn: UIButton!
    
    
    @IBOutlet weak var optionSelectBtn: UIButton!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    @IBOutlet weak var contentsTextView: UITextView!
    
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var safePayView: UIView!
    @IBOutlet weak var safePayCheckBtn: UIImageView!
    @IBOutlet weak var registerBtn: UIButton!
    
    
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
    
    
    
    //MARK: - Properties
    var isPatch : Bool = false
    var method = HTTPMethod.post
    
    var postData : ProductPostModel?
    
    var imagesData = [Default.defaultImage]
    var titleData: String?
    var categoryData: SecondCategoryResult?
    var tagData: [String] = []
    var priceData: Int?
    var shippingFeeData = false
    var optionData = OptionModel()
    var contentsData: String?
    var payData = false
    
    lazy var textViewY = contentsTextView.frame.origin.y
    var placeHolder = "여러 장의 상품사진과 구입연도, 브랜드, 사용감, 하자 유뮤 등 구매자에게 필요한 정보를 꼭 포함해 주세요. 문의를 줄이고 더 쉽게 판매할 수 있어요.(10자 이상)"
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setUI()
        
        if ( isPatch ){
            setData()
            method = HTTPMethod.patch
        }
        dismissKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavBar()
        hideTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showNavBar()
        showTabBar()
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        
        titleTextField.delegate = self
        priceTextField.delegate = self
        contentsTextView.delegate = self
    }
    
    private func setUI(){
       
        cameraView.makeCornerRound(radius: 10)
        
        registerView.layer.addBorder([.top], color: UIColor.systemGray5, width: 1)
        
        optionSelectBtn.makeCornerRound(radius: 10)
        optionSelectBtn.makeBorder(width: 1, color: UIColor.systemGray3)
        
        contentsTextView.makeBorder(width: 1, color: UIColor.systemGray3 )
        contentsTextView.makeCornerRound(radius: 10)
        
        safePayView.makeBorder(width: 2, color: UIColor.systemGray5)
        safePayView.makeCornerRound(radius: 10)
        registerBtn.makeCornerRound(radius: 10)
    }
    
    private func setData(){
        
        self.titleTextField.text = titleData
        showCategoryLabel()
        showTagStackView()
        priceTextField.text = makePriceString(priceData ?? 0)
        contentsTextView.text = contentsData
        contentsTextView.textColor = .black
    }
    
    private func showCategoryLabel(){
        
        categoryPlaceHolderLabel.isHidden = true
        
//        firstCategoryLabel.text = categoryData!.firstCategory
//        secondCategoryLabel.text = categoryData!.lastCategory
        
        view.addSubview(firstCategoryLabel)
        view.addSubview(rightShift)
        view.addSubview(secondCategoryLabel)
        view.addSubview(space)
        
        categoryStackView.addArrangedSubview(firstCategoryLabel)
        categoryStackView.addArrangedSubview(rightShift)
        categoryStackView.addArrangedSubview(secondCategoryLabel)
    }
    
    private func showTagStackView(){
        tagStackView.removeAllArrangedSubviews()
        if !tagData.isEmpty{
            for tag in tagData{
                
                tagStackView.addArrangedSubview(makeLabel(text: "#\(tag)", color: .black, font: .systemFont(ofSize: 16, weight: .semibold)))
                tagStackView.addArrangedSubview(makeTagSeperateView())
            }
        
        
        } else{
            tagStackView.addArrangedSubview(makeLabel(text: "# 태그", color: .systemGray3, font: .systemFont(ofSize: 20, weight: .bold)))
        }
        
    }
    
    private func showOptionLabel(){
        countLabel.text = "\(optionData.amount)개"
        stateLabel.text = optionData.isUsed ? "중고상품" : "새상품"
        changeLabel.text = optionData.changeable ? "교환가능" : "교환불가"
    }
    
    
    private func makeTagSeperateView() -> UIView{
        let view = UIView()
        view.frame.size = CGSize(width: 5, height: 7)

        view.backgroundColor = .systemGray3
        return view
    }
    
    private func checkValidPostData(images : [String]?, title : String? ,category : SecondCategoryResult?, tag: [String]?, price : Int? , contents : String?) throws -> ProductPostModel {
        
        
        if images == nil{ throw PostError.inValidData(msg: "상품사진을 등록 해주세요.") }
        else if title == nil && title?.count ?? 0 < 2{ throw PostError.inValidData(msg: "상품명을 두글자 이상 작성해주세요.") }
        else if category == nil { throw PostError.inValidData(msg: "카테고리를 선택해주세요.") }
        else if tag == nil { throw PostError.inValidData(msg: "태그를 입력해주세요.")}
        else if price == nil {throw PostError.inValidData(msg: "가격을 입력해주세요.")}
        else if contents == nil && contents?.count ?? 0 < 10 {throw PostError.inValidData(msg: "상품설명을 10글자 이상 입력해주세요.")}
        
        return ProductPostModel(
                         productImgs: images!,
                         title: title!,
                         firstCategoryId: category!.firstCategoryId,
                         lastCategoryId: category!.lastCategoryId,
                         tags: tag!,
                         price: price!,
                         contents: contents!,
                         amount: optionData.amount,
                         isUsed: optionData.isUsed,
                         changeable: optionData.changeable,
                         shippingFee: shippingFeeData,
                         pay: payData
                        )
        
    }
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        if (isPatch) { dismiss(animated: true) } else {
        let storyboard = UIStoryboard(name: "Tab", bundle: nil)
        
        guard let BaseVC = storyboard.instantiateViewController(withIdentifier: "BaseTabBarController") as? BaseTabBarController else { return }
        
        BaseVC.modalPresentationStyle = .fullScreen
            present(BaseVC, animated: false)
            
        }
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
        tagVC.tagData = tagData
        pushVC(tagVC)
    }
    
    @IBAction func shippingFeeBtnPressed(_ sender: UIButton) {
        shippingFeeData = !shippingFeeData
        
        if( shippingFeeData){
            sender.tintColor = Color.Red
        }
        else{
            sender.tintColor = UIColor.systemGray3
        }
    }
    
    @IBAction func optionBtnPressed(_ sender: UIButton) {
        
        let optionBS = UIStoryboard(name: "Post", bundle: nil).instantiateViewController(withIdentifier: "OptionBottomSheet") as! OptionBottomSheet
        
        optionBS.delegate = self
        optionBS.optionData = optionData
        
        let bottomSheet = MDCBottomSheetController(contentViewController: optionBS)
        present(bottomSheet, animated: true, completion: nil)
    }
    
    @IBAction func safePayTapped(_ sender: UITapGestureRecognizer) {
        payData = !payData
        if payData{
            safePayView.makeBorder(width: 2, color: Color.Red)
            safePayCheckBtn.tintColor = Color.Red
            
        } else {
            safePayView.makeBorder(width: 2, color: .systemGray5)
            safePayCheckBtn.tintColor = .systemGray3
        }
    }
    
    //MARK: - 최종 등록 버튼!!
    @IBAction func postCompleteBtnPressed(_ sender: UIButton) {
        view.endEditing(true)
        titleData = titleTextField.text
        priceData = Int(priceTextField.text!)
        contentsData = contentsTextView.text
       
        do {
            postData = try checkValidPostData(images: imagesData, title: titleData, category: categoryData, tag: tagData, price: priceData, contents: contentsData)
            
            ProductPostManager.shared.postPatchProduct(method: method, product: postData!) { (response) in
                switch response {
                
                case .success(let data) :
                    // MARK: - 상품 등록 성공!!
                    let responseData = data as! ProductPostResponse
                    
                    print("상품 ID: \(responseData.result.productId) 등록 완료.")
                    
                    guard let BaseVC = UIStoryboard(name: "Tab", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarController") as? BaseTabBarController else { return }
                    
                    BaseVC.modalPresentationStyle = .fullScreen
                    self.present(BaseVC, animated: false)
                    
                    
                    
                case .requestErr(let msg):
                    self.presentBottomAlert(message: msg as! String)
                    print(msg)
                case .decodeErr:
                    print("decodeError")
                case .pathErr :
                    print("pathErr")
                case .serverErr :
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                }
            }
        } catch PostError.inValidData(let msg) {
            presentBottomAlert(message: msg)
        } catch {
            print("다른 에러")
        }
        
        
    }
}

//MARK: - TextField Delegate
extension PostMainViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        switch textField{
        case titleTextField:
            print("타이틀 수정중")
            titleLine.backgroundColor = .black
        case priceTextField:
            print("가격 수정중")
            wonLabel.textColor = .black
            priceLine.backgroundColor = .black
        default: print("")
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        dismissKeyboard()
        
        guard let text = textField.text else {return }
            switch textField{
            case titleTextField:
                titleLine.backgroundColor = .systemGray3
               
                
                titleData = !text.isEmpty ? text : nil
                
            case priceTextField:
                print(text)
                priceTextField.text = makePriceString(Int(text) ?? 0)
                wonLabel.textColor = .systemGray3
                priceLine.backgroundColor = .systemGray5
                
                priceData = !text.isEmpty ? Int(text) ?? 0 : nil
                
            default: print("")
            }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

extension PostMainViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeHolder{
            textView.text = ""
        }
        textView.font = .systemFont(ofSize: 14, weight: .medium)
        textView.textColor = .black
        UIView.animate(withDuration: 0.4) {
            self.contentsTextView.frame.origin.y = CGFloat(self.textViewY - 200)
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.4) {
            self.contentsTextView.frame.origin.y = CGFloat(self.textViewY)
        }
        
        guard let text = textView.text else { return }
        if !text.isEmpty && text != placeHolder {
            contentsData = text
        } else {
            textView.text = placeHolder
            textView.font = .systemFont(ofSize: 16, weight: .regular)
            textView.textColor = .systemGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        true
    }
}




//MARK: - Data Send Delegate
extension PostMainViewController : optionDataDelegate,SecondCategoryDelegate,ArrayStringDelegate {
    
    func sendSecondCategory(_ data: SecondCategoryResult) {
        //유저가 카테고리 선택완료시 델리게이트로 데이터 받아옴
        categoryData = data
        showCategoryLabel()
    }
    
    
    func sendArrayString(_ data: [String]) {
        //유저가 태그 선택완료시 델리게이트로 데이터 받아옴
        tagData = data
        showTagStackView()
    }
    
    
    
    
    func sendData(_ data: OptionModel) {
        
        optionData = data
        showOptionLabel()
        
    }
    
    
}

