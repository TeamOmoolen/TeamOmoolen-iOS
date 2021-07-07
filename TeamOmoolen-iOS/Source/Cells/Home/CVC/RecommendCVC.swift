//
//  RecommendCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class RecommendCVC: UICollectionViewCell {
    static let identifier = "RecommendCVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var lensImageView: UIImageView!
    
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var lensNameLabel: UILabel!
    @IBOutlet weak var lensInfoLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

}

extension RecommendCVC {
    func setUI() {
        contentView.backgroundColor = .white
        modelImageView.image = UIImage(named: "abc")
        lensImageView.image = UIImage(named: "abc")
        
        brandNameLabel.text
         = "브랜드명"
        brandNameLabel.textColor = .omThirdGray
        brandNameLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 11)
        
        lensNameLabel.text = "렌즈명"
        lensNameLabel.textColor = .omMainBlack
        lensNameLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        lensInfoLabel.text = "직경 / 교체시기"
        lensInfoLabel.textColor = .omThirdGray
        lensInfoLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
        
        priceLabel.text = "가격"
        priceLabel.textColor = .omMainBlack
        priceLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
    }
    
    func initCell(brandName: String, lensName: String, diameter: Float, cycle: String, price: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        brandNameLabel.text = brandName
        lensNameLabel.text = lensName
        lensInfoLabel.text = "\(diameter)mm / \(cycle)"
                         
        priceLabel.text = "\(formatter.string(from: NSNumber(value: price))!)원"
    }
}
