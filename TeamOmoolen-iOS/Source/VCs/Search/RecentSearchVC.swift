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
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    var recentSearchCellHeight = 120
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setPhoneResolution()
        registerXib()
        setSearchInTableView()
        checkNotification()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Methods
    func setPhoneResolution(){
        if UIDevice.current.isiPhoneSE2 {
            tableViewTopConstraint.constant = 0
        } else if UIDevice.current.isiPhone12Pro {
            tableViewTopConstraint.constant = 85
        }
    }
    
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
    
    func checkNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(setCellHeight), name: NSNotification.Name("AdjustHeight"), object: nil)
    }
    
    //MARK: - objc function
   @objc func setCellHeight(notification: NSNotification){
        if let height = notification.object as? Int {
            recentSearchCellHeight = height
            searchInTableView.reloadData()
        }
    }
}

extension RecentSearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section{
        case 0:
            return CGFloat(recentSearchCellHeight) + 10
        case 1:
            if UIDevice.current.isiPhoneSE2 {
                return 750
            }
            else {
                return 660
            }
        
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
            cell.backgroundColor = .omWhite
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  PopularTVC.identifier, for: indexPath) as? PopularTVC else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.backgroundColor = .omWhite
            return cell
        default:
            return UITableViewCell()
        }
    }
}


