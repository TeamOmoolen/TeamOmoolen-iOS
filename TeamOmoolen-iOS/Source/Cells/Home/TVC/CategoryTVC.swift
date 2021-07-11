//
//  CategoryTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/07.
//

import UIKit

class CategoryTVC: UITableViewCell {
    static let identifier = "CategoryTVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var colorImageView: UIImageView!
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var clearImageView: UIImageView!
    @IBOutlet weak var clearLabel: UILabel!
    
    @IBOutlet weak var cospreImageView: UIImageView!
    @IBOutlet weak var cospreLabel: UILabel!
    
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var newLabel: UILabel!
    
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
        contentView.backgroundColor = .omWhite
        
        colorImageView.image = UIImage(named: "abc")
        colorLabel.text = "컬러"
        colorLabel.textColor = .omSecondGray
        colorLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
        
        clearImageView.image = UIImage(named: "abc")
        clearLabel.text = "투명"
        clearLabel.textColor = .omSecondGray
        clearLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
        
        cospreImageView.image = UIImage(named: "abc")
        cospreLabel.text = "코스프레"
        cospreLabel.textColor = .omSecondGray
        cospreLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
        
        newImageView.image = UIImage(named: "abc")
        newLabel.text = "신제품"
        newLabel.textColor = .omSecondGray
        newLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
    }
}
