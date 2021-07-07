//
//  ReviewTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit

class ReviewTVC: UITableViewCell {
    static let identifier = "ReviewTVC"
    
    // MARK: - UI Components
    @IBOutlet weak var dividerView: UIView!
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ReviewTVC {
    func setUI() {
        dividerView.backgroundColor = .omAlmostwhite
    }
}
