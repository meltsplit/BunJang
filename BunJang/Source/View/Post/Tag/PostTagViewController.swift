//
//  PostTagViewController.swift
//  BunJang
//
//  Created by 장석우 on 2022/07/17.
//

import UIKit

class PostTagViewController : BaseViewController{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var tagTextField: UITextField!
    
    
    //MARK: - Properties
    
    var delegate : ArrayStringDelegate?
    var tagData : [String] = []
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTappedAround()
        setDelegate()
        setUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavBar()
        
    }
    
    //MARK: - Custom Method
    
    private func setDelegate(){
        tagTextField.delegate = self
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
    }
    
    private func setBar(){
        hideTabBar()
        hideNavBar()
    }
    
    private func setUI(){
        
    }
    
    private func addTag(){
        let tagEmpty = tagTextField.text?.isEmpty ?? true
        if (!tagEmpty) {
            
            if tagData.count < 5{
                tagData.append(tagTextField.text!)
                
                tagCollectionView.reloadData()
            }
            else { 
                presentBottomAlert(message: "태그는 최대 5개까지 추가 가능합니다.")
            }
        }
        tagTextField.endEditing(true)
    }
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        popVC()
        delegate?.sendArrayString(tagData)
    }
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        tagTextField.endEditing(true)
    }
}

extension PostTagViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.cellIdentifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        cell.setData(indexPath,tagData)
        return cell
    }
    
    
    
}
//MARK: - CollectionView Delegate
extension PostTagViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.cellIdentifier, for: indexPath) as! TagCollectionViewCell
            
            cell.tagLabel.text = tagData[indexPath.row]
            cell.tagLabel.sizeToFit()
            
            //셀의 크기를 Label 크기 + 50(= 삭제 버튼을 위한 inset)
            let cellWidth = cell.tagLabel.frame.width + 50
            return CGSize(width: cellWidth, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
}
//MARK: - TextField Delegate
extension PostTagViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        addTag()
        textField.text = ""
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}

extension PostTagViewController : StringDelegate{
    func sendString(_ data: String) {
        print(data)
        if let index = tagData.firstIndex(of: data) {
            tagData.remove(at: index)
            print(tagData)
        }
        tagCollectionView.reloadData()
    }
    
    
}

