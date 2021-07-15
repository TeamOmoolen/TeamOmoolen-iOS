//
//  DetailService.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/13.
//

import Foundation
import Moya

enum DetailService {
    case product(param: String)
}

extension DetailService: TargetType {
    var baseURL: URL {
        return URL(string: Const.GeneralAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .product(let param):
            return "/api/products/\(param)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .product:
            return .get
        }
    }
    
    var sampleData: Data {
        return  "sampleData".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .product:
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
