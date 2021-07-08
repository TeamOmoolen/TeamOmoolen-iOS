//
//  FilterCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit

class FilterCVC: UICollectionViewCell {
    static let identifier = "FilterCVC"

    
    // MARK: - UI Components
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    
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
                
                filterLabel.textColor = .omMainOrange
                filterLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
            } else {
                backView.layer.borderWidth = 1
                backView.layer.borderColor = UIColor.omFifthGray.cgColor
                
                filterLabel.textColor = .omThirdGray
                filterLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
            }
        }
    }
}

extension FilterCVC {
    func setUI() {
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.omFifthGray.cgColor
        
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        
        filterLabel.text = "필터"
        filterLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        filterLabel.textColor = .omThirdGray
    }
    
    func initCell(filter: String) {
        filterLabel.text = filter
    }
}
