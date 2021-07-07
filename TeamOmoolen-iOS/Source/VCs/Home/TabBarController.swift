//
//  TabBarController.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setTabBar()
    }
    
    func setUI() {
        UITabBar.appearance().tintColor = UIColor.omMainBlack
    }
    
    func setTabBar() {
        let homeStoryboard = UIStoryboard.init(name: "Home", bundle: nil)
        let homeTab = homeStoryboard.instantiateViewController(identifier: "HomeVC")
        homeTab.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
        
        let searchStoryboard = UIStoryboard.init(name: "Search", bundle: nil)
        let searchTab = searchStoryboard.instantiateViewController(identifier: "SearchVC")
        searchTab.tabBarItem = UITabBarItem(title: "발견", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
        
        // 탭 연결
        let tabs =  [homeTab, searchTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = homeTab
    }

}
