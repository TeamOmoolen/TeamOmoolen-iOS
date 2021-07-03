//
//  SplashVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/03.
//

import UIKit

class SplashVC: UIViewController {
    // MARK: - Properties
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("splashVC")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
          // 1초 후 실행될 부분
            self.setIsLogin()
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    func setIsLogin() {
        if appDelegate?.isLogin == true {
            presentToHome()
        } else {
            presentToLogin()
        }
    }
    
    func presentToHome(){
        guard let homeVC = UIStoryboard(name: Const.Storyboard.Name.Home, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Home) as? HomeVC else {
            return
        }
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.modalTransitionStyle = .crossDissolve
        self.present(homeVC, animated: true, completion: nil)
    }
    
    func presentToLogin() {
        guard let loginVC = UIStoryboard(name: Const.Storyboard.Name.Login, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Login) as? UINavigationController else {
            return
        }
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        self.present(loginVC, animated: true, completion: nil)

    }

}