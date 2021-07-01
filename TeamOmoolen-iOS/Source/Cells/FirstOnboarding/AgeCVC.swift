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
        // Initialization code
    }
    
    // cell 선택 시
    override var isSelected: Bool {
        didSet {
            if isSelected {
                ageLabel.textColor = UIColor.orange
            } else {
                ageLabel.textColor = UIColor.darkGray
            }
        }
    }
    
    // MARK: - init Methods
    
    func initCell(age: String) {
        ageLabel.text = age
    }
}

