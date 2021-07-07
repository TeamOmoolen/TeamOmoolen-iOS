//
//  PopularTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/06.
//

import UIKit

class PopularTVC: UITableViewCell {

    static let identifier = "PopularTVC"
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var popularTableView: UITableView!
    
    //Mark: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        registerXib()
        setPopularTable()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI() {
        headerLabel.text = "인기검색어"
        headerLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
        //나중에 여기 시간 변수로 설정해야 할듯
        timeLabel.text = "오전 12:00 기준"
        timeLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
        
    }
    
    //Mark: - Methods
    func registerXib() {
        let PopularWordNib = UINib(nibName: PopularWordTVC.identifier, bundle: nil)
        
        popularTableView.register(PopularWordNib, forCellReuseIdentifier: PopularWordTVC.identifier)
    }
    
    func setPopularTable(){
        popularTableView.delegate = self
        popularTableView.dataSource = self
        popularTableView.separatorStyle = .none
    }
    

}

extension PopularTVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    /*func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        return 335
    }*/
}

extension PopularTVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  PopularWordTVC.identifier, for: indexPath) as? PopularWordTVC else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .omAlmostwhite
        return cell
    }
}


