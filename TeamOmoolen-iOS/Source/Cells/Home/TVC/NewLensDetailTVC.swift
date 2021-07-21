//
//  NewLensDetailTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class NewLensDetailTVC: UITableViewCell {
    static let identifier = "NewLensDetailTVC"

    // MARK: - UI Components
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lensImageView: UIImageView!
    
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var lensNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
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

extension NewLensDetailTVC {
    func setUI() {
        contentView.backgroundColor = .white
        
        backView.backgroundColor = .omAlmostwhite
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        
        brandNameLabel.text = "오렌즈"
        brandNameLabel.textColor = .omMainBlack
        brandNameLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 15)
        
        lensNameLabel.text = "브라운 컬러 익스 렌즈"
        lensNameLabel.textColor = .omMainBlack
        lensNameLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        priceLabel.text = "18,000원"
        priceLabel.textColor = .omMainBlack
        priceLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
    }
    
    func initCell(brand: String, name: String, price: Int, imageList: [String]) {
        let lensString = imageList[0]
        let lensUrl = URL(string: lensString)
        self.lensImageView.kf.setImage(with: lensUrl)
        self.lensImageView.layer.cornerRadius = lensImageView.frame.width / 2
        self.lensImageView.layer.masksToBounds = true
        
        brandNameLabel.text = brand
        lensNameLabel.text = name
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        priceLabel.text = "\(formatter.string(from: NSNumber(value: price))!)원"
    }
}
