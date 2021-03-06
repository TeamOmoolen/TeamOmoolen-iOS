//
//  OneMinDetailTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/07.
//

import UIKit

class OneMinDetailTVC: UITableViewCell {
    static let identifier = "OneMinDetailTVC"

    // MARK: - UI Components
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: - Local Variables
    var delegate: ViewModalProtocol?
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension OneMinDetailTVC {
    func setUI() {
        titleLabel.text = "렌즈 눈치 안보고 패션을 꾸밀 수 있다?"
        titleLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 14)
        titleLabel.textColor = .omMainBlack
        titleLabel.lineBreakMode = .byTruncatingTail
        
        subtitleLabel.text = "부제목"
        subtitleLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 11)
        subtitleLabel.textColor = .omThirdGray
        subtitleLabel.lineBreakMode = .byTruncatingTail
    }
    
    func initCell(title: String, subTitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subTitle
    }
}
