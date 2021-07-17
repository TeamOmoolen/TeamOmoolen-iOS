//
//  LoginVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/06/30.
//

import UIKit
import AuthenticationServices
import Moya

class LoginVC: UIViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var logoImage: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNavigationBarDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNavigationBarWillLoad()
    }
    
    // MARK: - Methods
    func setUI() {
        // appleLogin
        let appleLoginBtn = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        appleLoginBtn.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        view.addSubview(appleLoginBtn)
        
        appleLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        appleLoginBtn.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 24).isActive = true
        appleLoginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appleLoginBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        appleLoginBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        appleLoginBtn.heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
    func setNavigationBarDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
    }
    func setNavigationBarWillLoad() {
        self.navigationController?.navigationBar.isHidden = true
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
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }
    
    func postAppleLoginWithAPI(param: AppleLoginRequest) {
        LoginAPI.shared.postAppleLogin(param: param) { response in
            UserDefaults.standard.set(response.accessToken, forKey: "Accesstoken")
        }
    }
}

extension LoginVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:

            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email


            if let authorizationCode = appleIDCredential.authorizationCode,
               let identityToken = appleIDCredential.identityToken,
               let authString = String(data: authorizationCode, encoding: .utf8),
               let tokenString = String(data: identityToken, encoding: .utf8) {
//                print("authorizationCode: \(authorizationCode)")
//                print("identityToken: \(identityToken)")
//                print("authString: \(authString)")
//                print("tokenString: \(tokenString)")
//                
//                print("useridentifier: \(userIdentifier)")
//                print("fullName: \(fullName)")
//                print("email: \(email)")
            }
            
            let appleLoginRequest = AppleLoginRequest(userIdentifier, fullName?.familyName ?? "", fullName?.givenName ?? "")
            postAppleLoginWithAPI(param: appleLoginRequest)
            
            UserDefaults.standard.set(userIdentifier, forKey: "UserIdentifier")
            
        case let passwordCredential as ASPasswordCredential:

            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password

            print("username: \(username)")
            print("password: \(password)")

        default:
            break
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            guard let first = UIStoryboard(name: Const.Storyboard.Name.FirstOnboarding, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.FirstOnboarding) as? FirstOnboardingVC else {
                return
            }
            first.modalPresentationStyle = .fullScreen
            first.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(first, animated: true)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("login error")
    }
}


extension LoginVC: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
