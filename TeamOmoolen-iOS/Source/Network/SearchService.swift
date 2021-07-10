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
    case searchWindow
    
    case searchFilter(param: SearchFilterRequest)
}

extension SearchService: TargetType {
    var baseURL: URL {
        return URL(string: Const.GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .searchResult:
            return "/api/searchResult"
        case .searchWindow:
            return "/api/searchWindow"
        case .searchFilter:
            return "/api/getFilteredList"
        }

    }
    
    var method: Moya.Method {
        switch self {
        case .searchResult:
            return .get
        case .searchWindow:
            return .get
        case .searchFilter:
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
        case .searchWindow:
            return .requestPlain
        case .searchFilter(let searchFilterReques):
            return .requestJSONEncodable(searchFilterReques)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
