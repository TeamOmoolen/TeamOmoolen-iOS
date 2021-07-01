//
//  GenderCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/01.
//

import UIKit

class GenderCVC: UICollectionViewCell {
    static let identifier = "GenderCVC"
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initCell(genderImageName: String, gender: String) {
        if let image = UIImage(named: genderImageName)
        {
            genderImageView.image = image
        }
        genderLabel.text = gender
    }

}
