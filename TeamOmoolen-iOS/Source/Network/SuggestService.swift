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
    case suggestForyou(accesstoken: String, page: Int, sort: String, order: String)
}

extension SuggestService: TargetType {
    var baseURL: URL {
        return URL(string: Const.GeneralAPI.loginURL)!
    }
    
    var path: String {
        switch self {
        case .suggest:
            return "/api/suggest"
        case .suggestForyou:
            return "/api/suggest/foryou"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return "sampleData".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .suggest:
            return .requestPlain
        case .suggestForyou(_, let page, let sort, let order):
            return .requestParameters(parameters: ["page" : page, "sort" : sort, "order" : order], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .suggest(let accesstoken):
            return ["Content-Type": "application/json", "accesstoken" : accesstoken]
        case .suggestForyou(let accesstoken, _,_,_):
            return ["Content-Type": "application/json", "accesstoken" : accesstoken]
        }
    }
}
