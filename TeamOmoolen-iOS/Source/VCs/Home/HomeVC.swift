
//
//  HomeVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/03.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - UI Components
    

    // MARK: - Local Variables
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setList()
        
        registerXib()
        setHomeTableView()
    }
}

// MARK:- Custom Methods

extension HomeVC {
    func setUI() {
        
    }
    
    func setList() {
        
    }
    
    func registerXib() {
        
    }
    
    func setHomeTableView() {
        
    }
}

// MARK: - UITableView Delegate

extension HomeVC: UITableViewDelegate {
    
}

// MARK: - UITableView DataSource

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
