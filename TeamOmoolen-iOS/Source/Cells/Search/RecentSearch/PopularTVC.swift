//
//  PopularTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/06.
//

import UIKit

class PopularTVC: UITableViewCell {

    static let identifier = "PopularTVC"
    
    //MARK: - Properties
    var cellPopularList = [PopularResponse]()

    //MARK: - IB Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var popularTableView: UITableView!
    
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setPopularTable()
        registerXib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Methods
    func setUI() {
        headerLabel.text = "인기검색어"
        headerLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
        //나중에 여기 시간 변수로 설정해야 할듯
        timeLabel.text = "오전 12:00 기준"
        timeLabel.textColor = .omFourthGray
        timeLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
        
    }
    
    func setLensData(data : [PopularResponse]){
        print("data@@@",data)
        self.cellPopularList = data
        popularTableView.reloadData()
    }
    
    func registerXib() {
        let popularWordNib = UINib(nibName: PopularWordTVC.identifier, bundle: nil)
        
        popularTableView.register(popularWordNib, forCellReuseIdentifier: PopularWordTVC.identifier)
    }
    
    func setPopularTable(){
        popularTableView.delegate = self
        popularTableView.dataSource = self
        popularTableView.separatorStyle = .none
    }
}

//Mark: - Extensions
extension PopularTVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
}

extension PopularTVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellPopularList.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularWordTVC.identifier, for: indexPath) as? PopularWordTVC else {
            return UITableViewCell()
        }
        cell.initCell(rank: indexPath.row + 1, name: cellPopularList[indexPath.row].name)
        cell.selectionStyle = .none
        
        return cell
    }
}


