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
        contentView.backgroundColor = .omMainOrange
        
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
    }
    
    func initCell(color: String) {
//        hexColor = "#\(color)"
//        contentView.layer.backgroundColor = UIColor(hex: hexColor).cgColor
        
        switch color {
        case "clear":
            return
        case "black":
            return
        case "gray":
            return
        case "choco":
            return
        case "green":
            return contentView.layer.backgroundColor = UIColor.omMainGreen.cgColor
        case "brown":
            return
        case "purple":
            return
        case "blue":
            return contentView.layer.backgroundColor = UIColor.blue.cgColor
        case "gold":
            return
        case "pink":
            return
            
        default:
            return
        }
    }
}


