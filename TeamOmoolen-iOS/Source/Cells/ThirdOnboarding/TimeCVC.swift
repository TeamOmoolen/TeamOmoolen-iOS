//
//  TimeCVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/06/30.
//

import UIKit

class TimeCVC: UICollectionViewCell {

    //MARK: - IBOutlet Properties
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    //MARK: - View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUI()
    
    }
    
    //MARK: - Methods
    func setUI() {
        timeLabel.font = UIFont(name: "NotoSansCJKKR-DemiLight", size: 14)
        timeLabel.textColor = .omThirdGray
        timeLabel.center = CGPoint(x: self.timeView.frame.size.width / 2.0, y:self.timeView.frame.size.height / 2.0)
        timeView.layer.masksToBounds = false
        
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                
                self.layer.applyShadow(color: .omMainOrange, alpha: 0.14, x: 1, y: 1, blur: 7, spread: 0)
                self.contentView.layer.cornerRadius = 10.0
                self.contentView.layer.borderWidth = 1.0
                self.contentView.layer.borderColor = UIColor.omMainOrange.cgColor
                
                timeLabel.textColor = UIColor.omMainOrange
                
            } else {
                self.layer.applyShadow(color: .black, alpha: 0.14, x: 1, y: 1, blur: 7, spread: 0)
                self.contentView.layer.borderColor = UIColor.omWhite.cgColor
                
                timeLabel.textColor = UIColor.omThirdGray
            }
        }
    }
    
    //MARK: - Methods
    func setData(timeType: String) {
        timeLabel.text = timeType
        
    }

}
