//
//  LensBrandCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/02.
//

import UIKit

class LensBrandCVC: UICollectionViewCell {
    static let identifier = "LensBrandCVC"

    // MARK: - UI Components
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var brandLogoImageView: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    // cell 선택 시
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backView.layer.borderWidth = 1
                backView.layer.borderColor = UIColor.omMainOrange.cgColor
                
                brandNameLabel.textColor = .omMainOrange
                brandNameLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 10)
            } else {
                backView.layer.borderWidth = 1
                backView.layer.borderColor = UIColor.omFifthGray.cgColor
                
                brandNameLabel.textColor = .omThirdGray
                brandNameLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 10)
            }
        }
    }
    
}

// MARK: - Custom Methods

extension LensBrandCVC {
    func setUI() {
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.omFifthGray.cgColor
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        
        brandLogoImageView.contentMode = .center
        
        brandNameLabel.textColor = .omThirdGray
        brandNameLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 10)
    }
    
    func initCell(brandLogoImage: String, brandName: String) {
        if let image = UIImage(named: brandLogoImage)
        {
            brandLogoImageView.image = image
        }
        brandNameLabel.text = brandName
    }
}
