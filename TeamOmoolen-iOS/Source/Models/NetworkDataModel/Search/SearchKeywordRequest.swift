//
//  SearchKeywordRequest.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/12.
//

import Foundation

struct SearchKeywordRequest: Codable {
    
    let keyword: String
    
//    enum CodingKeys: String, CodingKey {
//        case keyword = "keyword"
//    }
    
    init(_ keyword: String) {
        self.keyword = keyword
    }
}
