//
//  LensColorCVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/06/30.
//

import UIKit

class LensColorCVC: UICollectionViewCell {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var lensColorView: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    
    // MARK: - View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Methods
    func initCell(color: UIColor, title: String) {
        lensColorView.backgroundColor = color
        colorLabel.text = title
    }
}
