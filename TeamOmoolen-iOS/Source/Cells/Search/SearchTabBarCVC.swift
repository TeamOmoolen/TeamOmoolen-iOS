//
//  SearchTabBarCVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/03.
//

import UIKit

class SearchTabBarCVC: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.textColor = .omFourthGray
    }
    
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
