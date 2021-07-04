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
    
    @IBOutlet weak var recommendImageView: UIImageView!
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
        recommendImageView.image = UIImage(named: "abc")
        
        brandNameLabel.text
         = "오렌즈"
        brandNameLabel.textColor = .omThirdGray
        brandNameLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 11)
        
        lensNameLabel.text = "브라운 컬러 렌즈"
        lensNameLabel.textColor = .omMainBlack
        lensNameLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        lensInfoLabel.text = "11.9mm/1Day(10dp)"
        lensInfoLabel.textColor = .omThirdGray
        lensInfoLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
        
        priceLabel.text = "18,000원"
        priceLabel.textColor = .omMainBlack
        priceLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
    }
    
    func initCell() {
        
    }
}
