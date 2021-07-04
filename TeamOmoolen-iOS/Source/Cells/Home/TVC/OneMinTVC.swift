//
//  OneMinTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/04.
//

import UIKit

class OneMinTVC: UITableViewCell {
    static let identifier = "OneMinTVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension OneMinTVC {
    func setUI() {
        contentView.backgroundColor = .white
    }
    
    func initCell() {
        
    }
}
