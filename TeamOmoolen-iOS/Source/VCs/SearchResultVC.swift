//
//  SearchResultVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/07.
//

import UIKit

class SearchResultVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    func getHomeWithAPI() {
        SearchAPI.shared.getSearchResultWithAPI() { response in
//            response.
        }
    }

}
