//
//  OneMinCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class OneMinCVC: UICollectionViewCell {
    static let identifier = "OneMinCVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

}

extension OneMinCVC {
    func setUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.omFifthGray.cgColor
        contentView.layer.masksToBounds = true
        
        topView.backgroundColor = .omMainOrange
        
        titleLabel.text = "오무렌 1분 렌즈 상식"
        titleLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        titleLabel.textColor = .white
        
        subtitleLabel.text = "이런이런 정보가 들어가요!"
        subtitleLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        subtitleLabel.textColor = .white
        
        moreButton.setTitle("1분 렌즈 상식 더보기", for: .normal)
        moreButton.tintColor = .omSecondGray
        moreButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        moreButton.backgroundColor = .omFifthGray
        moreButton.layer.cornerRadius = 10
        moreButton.layer.masksToBounds = true
    }
    
    func initCell() {
        
    }
}
