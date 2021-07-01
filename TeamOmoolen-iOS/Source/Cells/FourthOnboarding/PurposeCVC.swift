//
//  PurposeCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/02.
//

import UIKit

class PurposeCVC: UICollectionViewCell {
    static let identifier = "PurposeCVC"
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var purposeLabel: UILabel!
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setView()
    }
    
    // cell 선택 시
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backView.layer.borderColor = UIColor.omMainOrange.cgColor
                backView.layer.borderWidth = 1
                purposeLabel.textColor = .omMainOrange
            } else {
                backView.layer.borderColor = UIColor.omThirdGray.cgColor
                backView.layer.borderWidth = 0
                purposeLabel.textColor = .omThirdGray
            }
        }
    }
}

// MARK: - Custom Methods

extension PurposeCVC {
    func setView() {
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        
        purposeLabel.textColor = .omThirdGray
        purposeLabel.font = UIFont(name: "NotoSansCJKKR-DemiLight", size: 14)
    }
    
    func initCell(purpose: String) {
        purposeLabel.text = purpose
        
    }
}
