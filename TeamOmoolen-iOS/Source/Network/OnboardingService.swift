//
//  Service.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/04.
//

import Foundation
import Moya

enum OnboardingService {
//    static let key = "4803d10b09913b29b376e511c75a63fb"
    
    case onboarding(param: OnboardingRequest)
    case home
}

extension OnboardingService: TargetType {
    public var baseURL: URL {
        return URL(string: Const.GeneralAPI.baseURL)!
    }
    
    public var path: String {
        switch self {
        case .onboarding:
            return "/api/onboarding"
        case .home:
            return "/api/home"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .onboarding:
            return .post
        case .home:
            return .get
        }
    }
    
    public var sampleData: Data {
        return  "sampleData".data(using: .utf8)! 
    }
    
    public var task: Task {
        switch self {
        case .onboarding(let param):
            return .requestJSONEncodable(param)
        case .home:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}

