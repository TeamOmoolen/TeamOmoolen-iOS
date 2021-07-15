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
    
    func initCell(imageList: [String], brandName: String, lensName: String, diameter: Double, minCycle: Int, maxCycle: Int, pieces: Int) {
        brandNameLabel.text = brandName
        lensNameLabel.text = lensName
        
        var cycleData = ""
        if minCycle == maxCycle {
            if minCycle < 7 { cycleData = "\(minCycle)Day" }
            else if minCycle < 30 { cycleData = "\(minCycle/7)Week" }
            else { cycleData = "\(minCycle/30)Month" }
        } else if maxCycle < 7 {
            cycleData = "\(minCycle)~\(maxCycle)Days"
        } else if maxCycle < 30 {
            cycleData = "\(minCycle/7)~\(maxCycle/7)Weeks"
        } else if maxCycle > 30 {
            if minCycle/30 >= 6 { cycleData = "6months+" }
            else {cycleData = "\(minCycle/30)~\(maxCycle/30)Months"}
        }
        lensInfoLabel.text = "\(diameter)mm / \(cycleData)(\(pieces)p)"
        
        // kingfisher
        let modelURL = URL(string: imageList[1])
        modelImageView.kf.setImage(with: modelURL)
        
        let lensURL = URL(string: imageList[0])
        lensImageView.kf.setImage(with: lensURL)
        lensImageView.layer.cornerRadius = lensImageView.frame.width / 2
    }
}
