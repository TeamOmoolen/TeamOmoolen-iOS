//
//  AllClearTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/07.
//

import UIKit

class AllClearTVC: UITableViewCell {

    static let identifier = "AllClearTVC"
    
    //MARK: - IB Outlets
    @IBOutlet weak var allClearView: UIView!
    @IBOutlet weak var allClearLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setTapGesture()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: - Methods
    func setUI(){
        allClearLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        allClearLabel.textColor = .omFourthGray
        
        topView.backgroundColor = .omFifthGray
        bottomView.backgroundColor = .omFifthGray
    }
    
    func setTapGesture(){
        let allClearTap = UITapGestureRecognizer(target: self, action: #selector(allClear))
        allClearView.isUserInteractionEnabled = true
        allClearView.addGestureRecognizer(allClearTap)
    }
    
    //MARK: - @objc Methods
    @objc func allClear(){
        NotificationCenter.default.post(name: NSNotification.Name("AllClear"), object: nil)
    }
}
