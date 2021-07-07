//
//  PopularWordTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/06.
//

import UIKit

class PopularWordTVC: UITableViewCell {

    static let identifier = "PopularWordTVC"
    
    //Mark: - UI Components
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var searchWordLabel: UILabel!
    @IBOutlet weak var icImageView: UIImageView!
    
    //Mark: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        registerXib()
    }

    //Mark: - Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUI(){
        rankLabel.font = UIFont(name: "Roboto-Bold", size: 16)
        searchWordLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
    }
    
    func registerXib(){
        let PopularWordNib = UINib(nibName: PopularWordTVC.identifier, bundle: nil)
    }
    
}
