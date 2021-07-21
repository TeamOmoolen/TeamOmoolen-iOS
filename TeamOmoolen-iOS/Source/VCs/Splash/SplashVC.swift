//
//  SplashVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/03.
//

import UIKit

class SplashVC: UIViewController {
    
    // MARK: - Properties
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var splashImage: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
            self.setIsLogin()
        }
    }
    
    // MARK: - Methods
    private func setIsLogin() {
        if appDelegate?.isLogin == true {
            presentToHome()
        } else {
            presentToLogin()
        }
    }
    
    private func presentToHome(){
        guard let homeVC = UIStoryboard(name: Const.Storyboard.Name.Tabbar, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Tabbar) as? TabBarController else {
            return
        }
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.modalTransitionStyle = .crossDissolve
        self.present(homeVC, animated: true, completion: nil)
    }
    
    private func presentToLogin() {
        guard let loginVC = UIStoryboard(name: Const.Storyboard.Name.Login, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Login) as? UINavigationController else {
            return
        }
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        self.present(loginVC, animated: true, completion: nil)
    }

}
