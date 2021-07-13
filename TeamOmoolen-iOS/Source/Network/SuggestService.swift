//
//  SuggestService.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/13.
//

import Foundation
import Moya

enum SuggestService {
    case suggest(accesstoken: String)
}

extension SuggestService: TargetType {
    var baseURL: URL {
        return URL(string: Const.GeneralAPI.loginURL)!
    }
    
    var path: String {
        switch self {
        case .suggest:
            return "/api/suggest"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .suggest:
            return .get
        }
    }
    
    var sampleData: Data {
        return  "sampleData".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .suggest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .suggest(let accesstoken):
            return ["Content-Type": "application/json", "accesstoken" : accesstoken]
        }
    }
}
