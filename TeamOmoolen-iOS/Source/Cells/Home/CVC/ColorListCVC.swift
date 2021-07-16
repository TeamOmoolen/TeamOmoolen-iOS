//
//  ColorListCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/09.
//

import UIKit
import SnapKit

class ColorListCVC: UICollectionViewCell {
    static let identifier = "ColorListCVC"
    
    private lazy var colorGlitterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lensDescribeGlitter")
        return imageView
    }()
    
    private lazy var colorEtcImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lensDescribeEtccolor")
        return imageView
    }()
    
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
            contentView.layer.backgroundColor = UIColor.omClear.cgColor
            return
        case "black":
            contentView.layer.backgroundColor = UIColor.omMainBlack.cgColor
            return
        case "gray":
            contentView.layer.backgroundColor = UIColor.omSecondGray.cgColor
            return
        case "choco":
            contentView.layer.backgroundColor = UIColor.omChoco.cgColor
            return
        case "green":
            contentView.layer.backgroundColor = UIColor.omMainGreen.cgColor
            return
        case "brown":
            contentView.layer.backgroundColor = UIColor.omBrown.cgColor
            return
        case "purple":
            contentView.layer.backgroundColor = UIColor.omPurple.cgColor
            return
        case "blue":
            contentView.layer.backgroundColor = UIColor.omBlue.cgColor
            return
        case "gold":
            contentView.layer.backgroundColor = UIColor.omGold.cgColor
            return
        case "pink":
            contentView.layer.backgroundColor = UIColor.bubbleGumPink.cgColor
            return
        case "orange":
            contentView.layer.backgroundColor = UIColor.omMainOrange.cgColor
            return
        case "glitter":
            contentView.addSubview(colorGlitterImageView)
            colorGlitterImageView.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
            return
        case "yellow", "espressogold", "hazel", "rich brown", "white", "red":
            contentView.addSubview(colorEtcImageView)
            colorEtcImageView.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
            return
        default:
            contentView.layer.backgroundColor = UIColor.omWhite.cgColor
            return
        }
    }
}


