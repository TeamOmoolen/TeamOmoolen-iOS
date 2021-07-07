//
//  SearchWordTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/07.
//

import UIKit

class SearchWordTVC: UITableViewCell {

    static let identifier = "SearchWordTVC"
    
    //Mark: - IB Outlets
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    //Mark: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUI(){
        
    }
    
    
}
