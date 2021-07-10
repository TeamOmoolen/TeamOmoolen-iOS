//
//  SearchHomeCVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/04.
//

import UIKit

class SearchHomeCVC: UICollectionViewCell {

    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Methods
    static func nib() -> UINib{
        return UINib(nibName: "SearchHomeCVC", bundle: nil)
    }

}
