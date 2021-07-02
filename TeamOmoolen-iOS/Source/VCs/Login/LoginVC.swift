//
//  LoginVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/06/30.
//

import UIKit
import AuthenticationServices

class LoginVC: UIViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet var loginImageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNavigationBarDidLoad()
        loginTapAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNavigationBarDidLoad()
    }
    
    // MARK: - Methods
    func setUI() {
        let appleLoginBtn = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        appleLoginBtn.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        view.addSubview(appleLoginBtn)
        
        appleLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        appleLoginBtn.topAnchor.constraint(equalTo: loginImageView.bottomAnchor, constant: 40).isActive = true
        appleLoginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    func setNavigationBarDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.title = "맞춤 정보 설정"
        self.navigationController?.navigationBar.tintColor = .omSecondGray
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.omSecondGray, .font: UIFont(name: "NotoSansCJKKR-Medium", size: 16) as Any]
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icBack")
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icBack")
        self.navigationItem.backButtonTitle = ""
    }
    func setNavigationBarWillLoad() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func loginTapAction() {
        let login = UITapGestureRecognizer(target: self, action: #selector(login))
        loginImageView.isUserInteractionEnabled = true
        loginImageView.addGestureRecognizer(login)
    }
    
    // MARK: - @objc Methods
    @objc
    func login() {
        guard let nextVC = UIStoryboard(name: Const.Storyboard.Name.FirstOnboarding, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.FirstOnboarding) as? FirstOnboardingVC else {
            return
        }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        print("try login with apple")
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let reqeust = appleIDProvider.createRequest()
        reqeust.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [reqeust])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }
}

extension LoginVC: ASAuthorizationControllerDelegate {}


extension LoginVC: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
}
