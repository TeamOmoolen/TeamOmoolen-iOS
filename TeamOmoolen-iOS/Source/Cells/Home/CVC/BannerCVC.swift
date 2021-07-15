//
//  BannerCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit
import Kingfisher

class BannerCVC: UICollectionViewCell {
    static let identifier = "BannerCVC"
    
    // MARK: - UI Components
    
    private var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "abc")
        
        return imageView
    }()

    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

}

extension BannerCVC {
    func setUI() {
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        [bannerImageView].forEach { v in
            contentView.addSubview(v)
        }
        
        bannerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        bannerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func initCell(image: String) {
        let listURL = URL(string: image)
        bannerImageView.kf.setImage(with: listURL)
    }
}
