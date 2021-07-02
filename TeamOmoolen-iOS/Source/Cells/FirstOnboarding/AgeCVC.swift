//
//  AgeCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/01.
//

import UIKit

class AgeCVC: UICollectionViewCell {
    static let identifier = "AgeCVC"
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var ageLabel: UILabel!
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    // cell 선택 시
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backView.layer.borderColor = UIColor.omMainOrange.cgColor
                backView.layer.borderWidth = 1
                ageLabel.textColor = UIColor.omMainOrange
                ageLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
            } else {
                backView.layer.borderColor = UIColor.omThirdGray.cgColor
                backView.layer.borderWidth = 0
                ageLabel.textColor = UIColor.omThirdGray
                ageLabel.font = UIFont(name: "NotoSansCJKKR-DemiLight", size: 14)
            }
        }
    }
}

// MARK: - Custom Methods

extension AgeCVC {
    func setUI() {
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        
        ageLabel.textColor = .omThirdGray
        ageLabel.font = UIFont(name: "NotoSansCJKKR-DemiLight", size: 14)
    }
    
    func initCell(age: String) {
        ageLabel.text = age
        
    }
}

