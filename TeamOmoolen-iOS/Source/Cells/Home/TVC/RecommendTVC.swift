//
//  RecommendTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/04.
//

import UIKit

class RecommendTVC: UITableViewCell {
    static let identifier = "RecommendTVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension RecommendTVC {
    func setUI() {
        contentView.backgroundColor = .blue
    }
    
    func initCell() {
        
    }
}
