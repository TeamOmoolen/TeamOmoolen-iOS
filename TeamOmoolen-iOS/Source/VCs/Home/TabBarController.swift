//
//  TabBarController.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: Local Variables
    
    private var position = 0

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTabBar()
    }
    
    // MARK: - Methods
    
    func setUI() {
        UITabBar.appearance().tintColor = UIColor.omMainBlack
        
    }
    
    func setTabBar() {
        let homeStoryboard = UIStoryboard.init(name: "Home", bundle: nil)
        let homeTab = homeStoryboard.instantiateViewController(identifier: "NaviController")
        homeTab.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "btnHomeMaintabNormal"), selectedImage: UIImage(named: "btnHomeMaintabPressed"))
        
        
        let suggestStoryboard = UIStoryboard.init(name: "Suggest", bundle: nil)
        let suggestTab = suggestStoryboard.instantiateViewController(identifier: "NaviController")
        suggestTab.tabBarItem = UITabBarItem(title: "발견", image: UIImage(named: "btnDiscoverMaintabNormal"), selectedImage: UIImage(named: "btnDiscoverMaintabPressed"))
        
        let eventStoryboard = UIStoryboard.init(name: "Event", bundle: nil)
        let eventTab = eventStoryboard.instantiateViewController(identifier: "EventVC")
        eventTab.tabBarItem = UITabBarItem(title: "이벤트", image: UIImage(named: "btnEventMaintabNormal"), selectedImage: UIImage(named: "btnDiscoverMaintabPressed"))
        
        let tipStoryboard = UIStoryboard.init(name: "Tip", bundle: nil)
        let tipTab = tipStoryboard.instantiateViewController(identifier: "TipVC")
        tipTab.tabBarItem = UITabBarItem(title: "꿀팁", image: UIImage(named: "btnEventTipNormal"), selectedImage: UIImage(named: "btnEventTipPressed"))
        
        let myStoryboard = UIStoryboard.init(name: "MyPage", bundle: nil)
        let myTab = myStoryboard.instantiateViewController(identifier: "MyPageVC")
        myTab.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "btnMypageMaintabNormal"), selectedImage: UIImage(named: "btnMypageMaintabPressed"))
        
        // 탭 연결
        let tabs =  [homeTab, suggestTab, eventTab, tipTab, myTab]
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSansCJKKR-Medium", size: 9)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes as [NSAttributedString.Key : Any], for: .normal)
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = homeTab
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeIndex), name: NSNotification.Name("ChangeIndex"), object: nil)
    }
    
    @objc
    func changeIndex(_ notification: Notification) {
        position = notification.object as! Int
        NotificationCenter.default.post(name: NSNotification.Name("PostPosition"), object: position)
        self.selectedIndex = 1
    }

}
