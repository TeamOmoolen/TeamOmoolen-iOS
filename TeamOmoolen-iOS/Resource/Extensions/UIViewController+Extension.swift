//
//  UIViewController+extension.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/04.
//

import Foundation
import UIKit

extension UIViewController {
    func setupStatusBar(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let margin = view.layoutMarginsGuide
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            statusbarView.frame = CGRect.zero
            view.addSubview(statusbarView)
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                statusbarView.topAnchor.constraint(equalTo: view.topAnchor),
                statusbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
                statusbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                statusbarView.bottomAnchor.constraint(equalTo: margin.topAnchor)
            ])
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
    
    // 커스텀 네비게이션바
    func setupNavigationBar(customNavigationBarView: UIView, title: String) {
        let navigationBar = CustomNavigationBar(vc: self, title: title)

        customNavigationBarView.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: customNavigationBarView.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: customNavigationBarView.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: customNavigationBarView.safeAreaLayoutGuide.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: customNavigationBarView.bottomAnchor)
        ])
   
        setupStatusBar(.omWhite)
    }
    
    // apple id 로그인이 백그라운드에서 유효하지 않으면 바로 로그인화면으로 감.
//    func setNotificationLoginErr() {
//        NotificationCenter.default.addObserver(self, selector: #selector(forcePresentToLogin), name: NSNotification.Name("LoginFail"), object: nil)
//    }
//
//    @objc
//    func forcePresentToLogin() {
//        print("notification : setNotificationLoginErr")
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//            print("LoginFial: go to loginVC")
//            guard let loginVC = UIStoryboard(name: Const.Storyboard.Name.Login, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Login) as? UINavigationController else {
//                return
//            }
//            loginVC.modalPresentationStyle = .fullScreen
//            loginVC.modalTransitionStyle = .crossDissolve
//            self.present(loginVC, animated: true, completion: nil)
//        }
//    }
    
}
