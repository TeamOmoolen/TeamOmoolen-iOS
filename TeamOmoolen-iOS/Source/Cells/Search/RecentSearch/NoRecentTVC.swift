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
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: - Methods
    func setUI(){
        noRecentLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        noRecentLabel.textColor = .omFourthGray
    }
    
}
