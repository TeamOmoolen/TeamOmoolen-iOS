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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        setList()
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
        
    }
    
    func initCell(brandName: String, lensName: String) {
        brandLabel.text = brandName
        lensLabel.text = lensName
    }
}
