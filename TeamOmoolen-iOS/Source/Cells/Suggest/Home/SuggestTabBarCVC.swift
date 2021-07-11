//
//  SuggestTabBarCVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/09.
//

import UIKit

class SuggestTabBarCVC: UICollectionViewCell {

    static let identifier = "SuggestTabBarCVC"
    
    @IBOutlet weak var label: UILabel!
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    //MARK: - Functions
    func setUI(){
        label.font = UIFont(name: "Roboto-Regular", size: 13) 
        
    }
    //MARK: - Overrides
    override var isHighlighted: Bool{
        didSet{
            label.textColor = isHighlighted ? .omMainOrange : .omFourthGray
        }
    }
    
    override var isSelected: Bool{
        didSet{
            label.textColor = isSelected ? .omMainOrange: .omFourthGray
        }
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "SearchTabBarCVC", bundle: nil)
    }
}
