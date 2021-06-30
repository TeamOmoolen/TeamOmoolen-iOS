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
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - Methods
    func initCell(image: UIImage, title: String) {
//        if let image = UIImage(named: image) {
//            imageView.image = image
//        }
        imageView.image = image
        titleLabel.text = title
    }
}


