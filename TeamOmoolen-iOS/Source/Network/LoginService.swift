//
//  LoginService.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/09.
//

import Foundation
import Moya
import AuthenticationServices

enum LoginService {
    case login(param: AppleLoginRequest)
}

extension LoginService: TargetType {
    var baseURL: URL {
        return URL(string: Const.GeneralAPI.loginURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/apple"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        return  "sampleData".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .login(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
