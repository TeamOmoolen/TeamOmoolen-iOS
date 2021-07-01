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
    }
    
    // cell 선택 시
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backView.layer.borderColor = UIColor.omMainOrange.cgColor
                ageLabel.textColor = UIColor.omMainOrange
                ageLabel.textColor = UIColor.orange
            } else {
                backView.layer.borderColor = UIColor.omThirdGray.cgColor
                ageLabel.textColor = UIColor.omThirdGray
                ageLabel.textColor = UIColor.darkGray
            }
        }
    }
}

// MARK: - Custom Methods

extension AgeCVC {
    func setView() {
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.omThirdGray.cgColor
    }
    
    func initCell(age: String) {
        ageLabel.text = age
        
    }
}

