//
//  SearchDataModel.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/07.
//

import Foundation

// 검색결과 뷰가 나오면 천천히 짜보자

struct SearchDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SearchResponse

    enum CodingKeys: String, CodingKey {
        case status
        case success
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(SearchResponse.self, forKey: .data)) ?? SearchResponse(name: "")
    }
}

struct SearchResponse: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}
