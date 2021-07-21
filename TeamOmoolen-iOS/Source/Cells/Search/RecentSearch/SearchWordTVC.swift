//
//  SearchWordTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/07.
//

import UIKit

class SearchWordTVC: UITableViewCell {

    static let identifier = "SearchWordTVC"
    
    //MARK: - IB Outlets
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var removeImageView: UIImageView!
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setTapGesture()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUI(){
        searchLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        searchLabel.textColor = .omMainBlack
    }
    
    func setTapGesture(){
        let removeTap = UITapGestureRecognizer(target: self, action: #selector(removeWord))
        removeImageView.isUserInteractionEnabled = true
        removeImageView.addGestureRecognizer(removeTap)
    }
    
    @objc func removeWord(){
        NotificationCenter.default
            .post(name: NSNotification.Name("RemoveWord"), object: searchLabel.text)
    }
    
 
}
