//
//  SearchService.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/07.
//

import Foundation
import Moya

enum SearchService {
    case searchWindow
    
    case searchFilter(param: SearchFilterRequest)
}

extension SearchService: TargetType {
    var baseURL: URL {
        return URL(string: Const.GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .searchWindow:
            return "/api/searchWindow"
        case .searchFilter:
            return "/api/getFilteredList"
        }

    }
    
    var method: Moya.Method {
        switch self {
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
        case .searchWindow:
            return .requestPlain
        case .searchFilter(let searchFilterRequest):
            return .requestJSONEncodable(searchFilterRequest)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
