//
//  CategoryTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/04.
//

import UIKit

class CategoryTVC: UITableViewCell {
    static let identifier = "CategoryTVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CategoryTVC {
    func setUI() {
        contentView.backgroundColor = .red
    }
    
    func initCell() {
        
    }
}
