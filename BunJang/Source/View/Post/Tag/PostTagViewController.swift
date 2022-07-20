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
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
    }
    
    private func setBar(){
        hideTabBar()
        hideNavBar()
    }
    
    private func setUI(){
        true
    }
    
    
    //MARK: - IBAction
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        popVC()
        delegate?.sendArrayString(tagData)
    }
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        
        let tagEmpty = tagTextField.text?.isEmpty ?? true
        if (!tagEmpty) {
            
            if tagData.count <= 5{
                tagData.append(tagTextField.text!)
                
                tagCollectionView.reloadData()
            }
            else {  presentAlert(title: "태그는 최대 5개 까지 추가 가능합니다.")}
        }
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

