//
//  BannerCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit

class BannerCVC: UICollectionViewCell {
    static let identifier = "BannerCVC"
    
    private var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

}

extension BannerCVC {
    func setUI() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        [label].forEach { v in
            contentView.addSubview(v)
        }
        
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contentView.backgroundColor = .omAlmostwhite
    }
    
    func initCell(idx: Int) {
        label.text = "\(idx + 1) 번째"
    }
}
