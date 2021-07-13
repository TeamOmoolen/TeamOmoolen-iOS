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
    
    case searchKeyword(keyword: String)
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
        case .searchKeyword:
            return "/api/searchProduct"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchWindow:
            return .get
        case .searchFilter:
            return .get
        case .searchKeyword:
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
        case .searchFilter(let searchFilterReques):
            return .requestJSONEncodable(searchFilterReques)
        case .searchKeyword(let keyword):
            return .requestParameters(parameters: ["keyword" : keyword], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .searchWindow:
            return ["Content-Type": "application/json"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
