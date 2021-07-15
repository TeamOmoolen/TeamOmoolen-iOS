//
//  PopularWordTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/06.
//

import UIKit

class PopularWordTVC: UITableViewCell {

    static let identifier = "PopularWordTVC"
    
    //MARK: - UI Components
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var searchWordLabel: UILabel!
    @IBOutlet weak var icImageView: UIImageView!
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    //MARK: - Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUI(){
        rankLabel.font = UIFont(name: "Roboto-Bold", size: 16)
        searchWordLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
    }
    
    func initCell(rank: Int, name: String) {
        if rank <= 3 {
            rankLabel.textColor = .omMainOrange
        } else {
            rankLabel.textColor = .omFourthGray
            searchWordLabel.textColor = .omThirdGray
        }
        rankLabel.text = String(rank)
        searchWordLabel.text = name
    }
    
    

    
}
