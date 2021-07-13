//
//  PopularCVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/13.
//

import UIKit
import Kingfisher

class PopularCVC: UICollectionViewCell {
    static let identifier = "PopularCVC"
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var lensImageView: UIImageView!
    
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var lensNameLabel: UILabel!
    @IBOutlet weak var lensInfoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        // Initialization code
    }

    // MARK: - Methods
    func setUI() {
        
        brandNameLabel.text
         = "브랜드명"
        brandNameLabel.textColor = .omThirdGray
        brandNameLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 11)
        
        lensNameLabel.text = "렌즈명"
        lensNameLabel.textColor = .omMainBlack
        lensNameLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        
        lensInfoLabel.text = "직경 / 교체시기"
        lensInfoLabel.textColor = .omThirdGray
        lensInfoLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 11)
    }
    
    func initCell(imageList: [String], brandName: String, lensName: String, diameter: Double, cycle: Int, pieces: Int) {
        brandNameLabel.text = brandName
        lensNameLabel.text = lensName
        
        var cycleData = ""
        if cycle == 0 {
            cycleData = "1Day"
        } else if cycle == 1 {
            cycleData = "1Week"
        } else if cycle == 2 {
            cycleData = "2Week"
        } else if cycle == 3 {
            cycleData = "1Month"
        } else if cycle == 4 {
            cycleData = "2~3Month"
        }
        lensInfoLabel.text = "\(diameter)mm / \(cycleData)(\(pieces)p)"
        
        // kingfisher
        let modelURL = URL(string: imageList[0])
        modelImageView.kf.setImage(with: modelURL)
        
        let lensURL = URL(string: imageList[1])
        lensImageView.kf.setImage(with: lensURL)
    }
}
