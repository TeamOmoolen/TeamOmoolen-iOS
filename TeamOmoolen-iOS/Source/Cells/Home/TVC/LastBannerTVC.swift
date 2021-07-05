//
//  LastBannerTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class LastBannerTVC: UITableViewCell {
    static let identifier = "LastBannerTVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension LastBannerTVC {
    func setUI() {
        contentView.backgroundColor = .omMainOrange
    }
}
