//
//  LensKindCVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/06/30.
//

import UIKit

class LensKindCVC: UICollectionViewCell {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        contentView.layer.cornerRadius = 20
//        contentView.layer.masksToBounds = true

        
        titleLabel.font = UIFont(name: "NotoSansCJKKR-DemiLight", size: 14)
        
    }
    
    // MARK: - Methods
    func initCell(image: UIImage, title: String) {
//        if let image = UIImage(named: image) {
            imageView.image = image
//        }
        titleLabel.text = title
    }
    
    // MARK: - Override
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.textColor = .omMainOrange
                self.contentView.layer.borderColor = UIColor.omMainOrange.cgColor
                self.contentView.layer.borderWidth = 2
                self.layer.applyShadow(color: .omMainOrange, alpha: 0.14, x: 1, y: 1, blur: 7, spread: 0)
            } else {
                titleLabel.textColor = .omMainBlack
                self.contentView.layer.borderColor = UIColor.omWhite.cgColor
                self.contentView.layer.borderWidth = 2
                self.layer.applyShadow(color: .omMainBlack, alpha: 0.14, x: 1, y: 1, blur: 7, spread: 0)
                
            }
        }
    }
}
