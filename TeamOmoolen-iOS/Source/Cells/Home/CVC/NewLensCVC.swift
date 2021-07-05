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
    
    
    @IBOutlet weak var firstBackView: UIView!
    @IBOutlet weak var firstBrandLabel: UILabel!
    @IBOutlet weak var firstLensLabel: UILabel!
    @IBOutlet weak var firstPriceLabel: UILabel!
    @IBOutlet weak var firstImageView: UIImageView!
    
    
    @IBOutlet weak var secondBackView: UIView!
    @IBOutlet weak var secondBrandLabel: UILabel!
    @IBOutlet weak var secondLensLabel: UILabel!
    @IBOutlet weak var secondPriceLabel: UILabel!
    @IBOutlet weak var secondImageView: UIImageView!
    
    
    @IBOutlet weak var thirdBackView: UIView!
    @IBOutlet weak var thirdBrandLabel: UILabel!
    @IBOutlet weak var thirdLensLabel: UILabel!
    @IBOutlet weak var thirdPriceLabel: UILabel!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    
    
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
        
        // 첫번째 렌즈 정보
        firstBackView.backgroundColor = .omAlmostwhite
        firstBackView.layer.cornerRadius = 10
        firstBackView.layer.masksToBounds = true
        
        firstBrandLabel.text = "오렌즈"
        firstBrandLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 15)
        firstBrandLabel.textColor = .omMainBlack
        
        firstLensLabel.text = "브라운 컬러 익스 렌즈"
        firstLensLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        firstLensLabel.textColor = .omSecondGray
        
        firstPriceLabel.text = "18,000원"
        firstPriceLabel.font = UIFont(name: "Roboto-Bold", size: 14)
        firstPriceLabel.textColor = .omMainBlack
        
        // 두번째 렌즈 정보
        secondBackView.backgroundColor = .omAlmostwhite
        secondBackView.layer.cornerRadius = 10
        secondBackView.layer.masksToBounds = true
        
        secondBrandLabel.text = "오렌즈"
        secondBrandLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 15)
        secondBrandLabel.textColor = .omMainBlack
        
        secondLensLabel.text = "브라운 컬러 익스 렌즈"
        secondLensLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        secondLensLabel.textColor = .omSecondGray
        
        secondPriceLabel.text = "18,000원"
        secondPriceLabel.font = UIFont(name: "Roboto-Bold", size: 14)
        secondPriceLabel.textColor = .omMainBlack
        
        // 세번째 렌즈 정보
        thirdBackView.backgroundColor = .omAlmostwhite
        thirdBackView.layer.cornerRadius = 10
        thirdBackView.layer.masksToBounds = true
        
        thirdBrandLabel.text = "오렌즈"
        thirdBrandLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 15)
        thirdBrandLabel.textColor = .omMainBlack
        
        thirdLensLabel.text = "브라운 컬러 익스 렌즈"
        thirdLensLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        thirdLensLabel.textColor = .omSecondGray
        
        thirdPriceLabel.text = "18,000원"
        thirdPriceLabel.font = UIFont(name: "Roboto-Bold", size: 14)
        thirdPriceLabel.textColor = .omMainBlack
    }
    
    func setList() {
        
    }
    
    func initCell(brandName: String, lensName: String) {
        brandLabel.text = brandName
        lensLabel.text = lensName
    }
}
