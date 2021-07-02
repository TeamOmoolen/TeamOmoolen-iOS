//
//  FunctionCVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/06/30.
//

import UIKit

class FunctionCVC: UICollectionViewCell {

    static let identifier : String = "FunctionCVC"
    
    //Mark: - IBOutlet Properties
    
    @IBOutlet weak var functionView: UIView!
    @IBOutlet weak var functionLabel: UILabel!
    
    //Mark: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()

    }
    
    //Mark: - Methods

    func setUI() {
        functionLabel.center = CGPoint(x: self.functionView.frame.size.width / 2.0, y:self.functionView.frame.size.height / 2.0)
        functionLabel.font = UIFont(name: "NotoSansCJKKR-DemiLight", size: 14)
        
    }
    
    //Mark: - Methods
    func setData(functionName: String) {
        
        functionLabel.text = functionName
        functionLabel.textColor = .omThirdGray
        
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.applyShadow(color: .omMainOrange, alpha: 0.14, x: 1, y: 1, blur: 7, spread: 0)
                self.contentView.layer.borderColor = UIColor.omMainOrange.cgColor
                self.contentView.layer.borderWidth = 1.0
                self.contentView.layer.cornerRadius = 10

                functionLabel.textColor = UIColor.omMainOrange

                
            } else {
                self.layer.applyShadow(color: .black, alpha: 0.14, x: 1, y: 1, blur: 7, spread: 0)
                self.contentView.layer.borderColor = UIColor.omWhite.cgColor
                functionLabel.textColor = UIColor.omThirdGray
                functionView.layer.borderColor = UIColor.white.cgColor

            }
        }
    }

}
