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
        
        titleLabel.font = UIFont(name: "NotoSansCJKKR-DemiLight", size: 14)
    }
    // MARK: - Methods
    func initCell(image: UIImage, title: String) {
//        if let image = UIImage(named: image) {
            imageView.image = image
//        }
        titleLabel.text = title
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.applyShadow(color: .omMainOrange, alpha: 0.14, x: 1, y: 1, blur: 7, spread: 0)
                self.contentView.layer.borderColor = UIColor.omMainOrange.cgColor
                self.contentView.layer.borderWidth = 1
                titleLabel.textColor = .omMainOrange
            } else {
                self.layer.applyShadow(color: .omMainBlack, alpha: 0.14, x: 1, y: 1, blur: 7, spread: 0)
                self.contentView.layer.borderColor = UIColor.omWhite.cgColor
                self.contentView.layer.borderWidth = 0
                titleLabel.textColor = .omMainBlack
            }
        }
    }
}
