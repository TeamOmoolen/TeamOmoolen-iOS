//
//  PopularTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/06.
//

import UIKit

class PopularTVC: UITableViewCell {

    static let identifier = "PopularTVC"
    
    //Mark: - Properties
    private var popularSearchList = [PopularResponse]()
    private var popularCellList = [PopularCellDataModel]()

    //Mark: - IB Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var popularTableView: UITableView!
    
    
    //Mark: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setPopularTable()
        registerXib()
        getPopularSearchWithAPI()
        initPopularSearchList()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Mark: - Methods
    func setUI() {
        headerLabel.text = "인기검색어"
        headerLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 16)
        //나중에 여기 시간 변수로 설정해야 할듯
        timeLabel.text = "오전 12:00 기준"
        timeLabel.textColor = .omFourthGray
        timeLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 12)
        
    }
    
    func initPopularSearchList(){
        for i in 0..<9 {
            popularCellList.append(contentsOf: [
                PopularCellDataModel(rank: i+1, name: "ㅇ")
            ])
        }
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
    
    func getPopularSearchWithAPI() {
        SearchAPI.shared.getPopularSearch { response in
            self.popularSearchList = response
            print("여기야 여기 : \(self.popularSearchList)")
        }
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
        return popularCellList.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularWordTVC.identifier, for: indexPath) as? PopularWordTVC else {
            return UITableViewCell()
        }
        cell.initCell(rank: popularCellList[indexPath.row].rank, name: popularCellList[indexPath.row].name)
        cell.selectionStyle = .none
        
        return cell
    }
}


