//
//  NewLensCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class NewLensCVC: UICollectionViewCell {
    static let identifier = "NewLensCVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var brandImageView: UIImageView!
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var lensLabel: UILabel!
    
    @IBOutlet weak var newLensTableView: UITableView!
    
    // MARK: - Local Variables
    
    private var newLensList: [NewLens] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        setList()
        registerXib()
        setTableView()
    }
    
}

extension NewLensCVC {
    func setUI() {
        contentView.backgroundColor = .white
        modelImageView.image = UIImage(named: "abc")
        modelImageView.layer.cornerRadius = 10
        modelImageView.layer.masksToBounds = true
        
        brandImageView.image = UIImage(named: "abc")
        brandImageView.layer.cornerRadius = brandImageView.frame.width / 2
        brandImageView.layer.masksToBounds = true
        
        brandLabel.text = "브랜드명"
        brandLabel.textColor = .omWhite
        brandLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
        
        lensLabel.text = "제품 상세 정보 이름"
        lensLabel.textColor = .omWhite
        lensLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
    }
    
    func setList() {
        newLensList.append(contentsOf: [
            NewLens(brandName: "오렌즈", lensName: "브라운 컬러 익스 렌즈", price: 18000),
            NewLens(brandName: "오렌즈", lensName: "브라운 컬러 익스 렌즈", price: 18000),
            NewLens(brandName: "오렌즈", lensName: "브라운 컬러 익스 렌즈", price: 18000)
        ])
    }
    
    func registerXib() {
        let detailNib = UINib(nibName: NewLensDetailTVC.identifier, bundle: nil)
        newLensTableView.register(detailNib, forCellReuseIdentifier: NewLensDetailTVC.identifier)
    }
    
    func setTableView() {
        newLensTableView.delegate = self
        newLensTableView.dataSource = self
        
        newLensTableView.separatorStyle = .none
        
        newLensTableView.isScrollEnabled = false
    }
    
    func initCell(brandName: String, lensName: String) {
        brandLabel.text = brandName
        lensLabel.text = lensName
    }
}

extension NewLensCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
}

extension NewLensCVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newLensList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewLensDetailTVC.identifier) as? NewLensDetailTVC else {
            return UITableViewCell()
        }
        let data = newLensList[indexPath.row]
        cell.initCell(lensImage: "abc", brandName: data.brandName, lensName: data.lensName, price: data.price)
        return cell
    }
    
}
