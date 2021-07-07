//
//  NoRecentTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/07.
//

import UIKit

class NoRecentTVC: UITableViewCell {

    static let identifier = "NoRecentTVC"
    
    @IBOutlet weak var noRecentLabel: UILabel!
    
    //Mark: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
