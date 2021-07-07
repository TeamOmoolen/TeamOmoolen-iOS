//
//  SearchInTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/06.
//

import UIKit

class SearchInTVC: UITableViewCell {

    static let identifier = "SearchInTVC"

    //Mark: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        registerXib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func registerXib() {
        let SearchInNib = UINib(nibName: SearchInTVC.identifier, bundle: nil)
    }
    
}


