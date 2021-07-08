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
        
//        let sampleStoryboard = UIStoryboard.init(name: "", bundle: nil)
//        let sampleTab = sampleStoryboard.instantiateViewController(identifier: "")
//        sampleTab.tabBarItem = UITabBarItem(title: "발견", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
        
        // 탭 연결
        let tabs =  [homeTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = homeTab
    }

}
