//
//  ColorListCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/09.
//

import UIKit

class ColorListCVC: UICollectionViewCell {
    static let identifier = "ColorListCVC"
    
    // MARK: - Local Variables
    private var hexColor = ""
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

}

extension ColorListCVC {
    func setUI() {
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
    }
    
    func initCell(color: String) {
        switch color {
        case "clear":
            contentView.layer.borderColor = UIColor.omThirdGray.cgColor
            contentView.layer.borderWidth = 1
        case "black":
            contentView.layer.backgroundColor = UIColor.omMainBlack.cgColor
        case "gray":
            contentView.layer.backgroundColor = UIColor.omSecondGray.cgColor
        case "choco":
            return
        case "green":
            contentView.layer.backgroundColor = UIColor.omMainGreen.cgColor
        case "brown":
            return
        case "purple":
            return
        case "blue":
            contentView.layer.backgroundColor = UIColor.blue.cgColor
        case "gold":
            return
        case "pink":
            contentView.layer.backgroundColor = UIColor.bubbleGumPink.cgColor
            
        default:
            return
        }
    }
}


