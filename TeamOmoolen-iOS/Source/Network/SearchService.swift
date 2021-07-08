//
//  SearchService.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/07.
//

import Foundation
import Moya

enum SearchService {
    case searchResult
    case popular
}

extension SearchService: TargetType {
    var baseURL: URL {
        return URL(string: Const.GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .searchResult:
            return "/api/searchResult"
        case .popular:
            return "/api/popular"
        }

    }
    
    var method: Moya.Method {
        switch self {
        case .searchResult:
            return .get
        case .popular:
            return .get
        }
    }
    
    var sampleData: Data {
        return  "sampleData".data(using: .utf8)! 
    }
    
    var task: Task {
        switch self {
        case .searchResult:
            return .requestPlain
        case .popular:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
