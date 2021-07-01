//
//  GenderCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/01.
//

import UIKit

class GenderCVC: UICollectionViewCell {
    static let identifier = "GenderCVC"
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // cell 선택 시
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backView.layer.borderColor = UIColor.omMainOrange.cgColor
                genderLabel.textColor = UIColor.omMainOrange
            } else {
                backView.layer.borderColor = UIColor.omThirdGray.cgColor
                genderLabel.textColor = UIColor.omThirdGray
            }
        }
    }
}

// MARK: - Custom Methods

extension GenderCVC {
    func setView() {
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.omThirdGray.cgColor
        // Initialization code
    }
    
    func initCell(genderImageName: String, gender: String) {
        if let image = UIImage(named: genderImageName)
        {
            genderImageView.image = image
        }
        genderLabel.text = gender
    }
}
