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
        let homeTab = homeStoryboard.instantiateViewController(identifier: "NaviController")
        homeTab.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
        
//        let recommendStoryboard = UIStoryboard.init(name: "", bundle: nil)
//        let recommendTab = recommendStoryboard.instantiateViewController(identifier: "")
//        recommendTab.tabBarItem = UITabBarItem(title: "발견", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
//        
//        let eventStoryboard = UIStoryboard.init(name: "", bundle: nil)
//        let eventTab = eventStoryboard.instantiateViewController(identifier: "")
//        eventTab.tabBarItem = UITabBarItem(title: "이벤트", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
//        
//        let tipStoryboard = UIStoryboard.init(name: "", bundle: nil)
//        let tipTab = tipStoryboard.instantiateViewController(identifier: "")
//        tipTab.tabBarItem = UITabBarItem(title: "꿀팁", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
//        
//        let myStoryboard = UIStoryboard.init(name: "", bundle: nil)
//        let myTab = myStoryboard.instantiateViewController(identifier: "")
//        myTab.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "abc"), selectedImage: UIImage(named: "abc"))
        
        // 탭 연결
        let tabs =  [homeTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = homeTab
    }

}
