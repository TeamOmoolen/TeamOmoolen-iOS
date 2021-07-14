//
//  AppDelegate.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/06/30.
//

import UIKit
import AuthenticationServices
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var isLogin = false
    
    // 앱을 실행할 경우 사용중단 분기처리
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let userIdentifier = UserDefaults.standard.string(forKey: "UserIdentifier") ?? ""
        // Apple login
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
            
            print(userIdentifier)
            
            switch credentialState {
            case .revoked:
                // Apple ID 사용 중단 경우.
                // 로그아웃
                print("revoked")
                print("go to login")
                self.isLogin = false
            case .authorized:
                print("authorized")
                print("go to home")
                self.isLogin = true
            case .notFound:
                // 잘못된 useridentifier 로 credentialState 를 조회하거나 애플로그인 시스템에 문제가 있을 때
                print("notFound")
                print("go to login")
                self.isLogin = false
            default:
                print("default")
                print("go to login")
                self.isLogin = false
            }
        }
        return true
    }
     
    // background 에 앱이 내려가 있는 경우 사용중단 분기처리
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        let userIdentifier = UserDefaults.standard.string(forKey: "UserIdentifier") ?? ""
//
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
//            switch credentialState {
//            case .revoked:
//                // Apple ID 사용 중단 경우.
//                // 로그아웃
//                print("background: revoked")
//                print("background: go to login")
//                self.isLogin = false
//                NotificationCenter.default.post(name: NSNotification.Name("LoginFail"), object: nil)
//            case .authorized:
//                print("background: authorized")
//                print("background: go to home")
//                self.isLogin = true
//            case .notFound:
//                // 잘못된 useridentifier 로 credentialState 를 조회하거나 애플로그인 시스템에 문제가 있을 때
//                print("background: notFound")
//                print("background: go to login")
//                self.isLogin = false
//                NotificationCenter.default.post(name: NSNotification.Name("LoginFail"), object: nil)
//            default:
//                print("background: default")
//                print("background: go to login")
//                self.isLogin = false
//                NotificationCenter.default.post(name: NSNotification.Name("LoginFail"), object: nil)
//            }
//        }
//    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

