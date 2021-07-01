//
//  LensColorCVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/06/30.
//

import UIKit

class LensColorCVC: UICollectionViewCell {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.contentMode = .center
    }

    // MARK: - Methods
    func initCell(image: UIImage) {
        imageView.image = image
    }
}
