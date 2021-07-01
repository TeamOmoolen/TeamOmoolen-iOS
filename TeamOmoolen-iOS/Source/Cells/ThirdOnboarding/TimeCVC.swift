//
//  TimeCVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/06/30.
//

import UIKit

class TimeCVC: UICollectionViewCell {

    //Mark: - IBOutlet Properties
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    //Mark: - View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        timeView.layer.cornerRadius = 10
        timeView.layer.shadowOffset = CGSize(width: 2, height: 2)
        timeView.layer.shadowRadius = 7
        timeView.layer.shadowColor = UIColor.black.cgColor
        timeView.layer.shadowOpacity = 0.14
        
        timeLabel.center = CGPoint(x: self.timeView.frame.size.width / 2.0, y:self.timeView.frame.size.height / 2.0)
    }
    
    //Mark: - Methods
    func setData(timeType: String) {
        timeLabel.text = timeType
        
    }

}
