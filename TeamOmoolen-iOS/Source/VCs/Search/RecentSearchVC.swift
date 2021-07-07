//
//  RecentSearchVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/04.
//

import UIKit

class RecentSearchVC: UIViewController {

    //Mark: - UI Components
    @IBOutlet weak var searchInTableView: UITableView!
    
    
    //Mark: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        setSearchInTableView()
        print(searchInTableView.frame.width)

        // Do any additional setup after loading the view.
    }
    
    //Mark: - Methods
    func registerXib(){
        let searchInNib = UINib(nibName:SearchInTVC.identifier, bundle: nil)
        searchInTableView.register(searchInNib, forCellReuseIdentifier: SearchInTVC.identifier)
    
        let popularNib = UINib(nibName: PopularTVC.identifier, bundle: nil)
        searchInTableView.register(popularNib, forCellReuseIdentifier: PopularTVC.identifier)
    
    }
    
    func setSearchInTableView() {
        searchInTableView.delegate = self
        searchInTableView.dataSource = self
        searchInTableView.separatorStyle = .none
    }


}

extension RecentSearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 222
        case 1:
            return 537
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        return 335
    
    }
    
    
    
    
}

extension RecentSearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  SearchInTVC.identifier, for: indexPath) as? SearchInTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.backgroundColor = .omSecondGray
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  PopularTVC.identifier, for: indexPath) as? PopularTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.backgroundColor = .omMainOrange
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    

    
}
