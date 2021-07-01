//
//  LensColorCVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/06/30.
//

import UIKit

class LensColorCVC: UICollectionViewCell {
    // MARK: - Properties
    var imageString = ""
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.contentMode = .center
    }

    // MARK: - Methods
//    func initCell(image: UIImage) {
//        imageView.image = image
//    }
    func initCell(image: String) {
        self.imageString = image
        imageView.image = UIImage(named: image) ?? UIImage()
    }
    
    // MARK: - Override
    override var isSelected: Bool {
        didSet {
            if isSelected {
                imageView.image = UIImage(named: "\(imageString)Pressed") ?? UIImage()
            } else {
                imageView.image = UIImage(named: imageString) ?? UIImage()
            }
        }
    }
}
