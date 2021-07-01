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
    
    //Mark: - Methods
    func setData(functionName: String) {
        
        functionLabel.text = functionName
        
        
        
        functionView.layer.cornerRadius = 10
        functionView.layer.shadowOffset = CGSize(width: 2, height: 2)
        functionView.layer.shadowRadius = 7
        functionView.layer.shadowColor = UIColor.black.cgColor
        functionView.layer.shadowOpacity = 0.14
        
        
    }
    
    //Mark: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       functionLabel.center = CGPoint(x: self.functionView.frame.size.width / 2.0, y:self.functionView.frame.size.height / 2.0)

    }

}
