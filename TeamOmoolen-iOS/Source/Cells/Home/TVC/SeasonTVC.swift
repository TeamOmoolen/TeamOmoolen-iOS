//
//  SeasonTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/04.
//

import UIKit

class SeasonTVC: UITableViewCell {
    static let identifier = "SeasonTVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension SeasonTVC {
    func setUI() {
        contentView.backgroundColor = .purple
    }
    
    func initCell() {
        
    }
}
