//
//  AllClearTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/07.
//

import UIKit

class AllClearTVC: UITableViewCell {

    static let identifier = "AllClearTVC"
    
    //Mark: - IB Outlets
    @IBOutlet weak var allClearView: UIView!
    
    //Mark: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTapGesture()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //Mark: - Methods
    func setTapGesture(){
        let allClearTap = UITapGestureRecognizer(target: self, action: #selector(allClear))
        allClearView.isUserInteractionEnabled = true
        allClearView.addGestureRecognizer(allClearTap)
    }
    
    //Mark: - @objc Methods
    @objc func allClear(){
        //send notification
        NotificationCenter.default.post(name: NSNotification.Name("AllClear"), object: nil)
    }
}
