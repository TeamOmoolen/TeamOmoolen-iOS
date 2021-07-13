//
//  File.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/09.
//

import Foundation
struct SearchResultDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SearchResultResponse?
    
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
        data = (try? values.decode(SearchResultResponse.self, forKey: .data)) ?? nil
    }
}

struct SearchResultResponse: Codable {
    let products: [Product]
    let totalPage: Int
    
    enum CodingKeys: String, CodingKey {
        case products = "items"
        case totalPage
    }
    
}

// MARK: - Product
struct Product: Codable {
    let id, name: String
    let imageList: [String]
    let category, color: String
    let otherColorList: [String]
    let price: Int
    let brand, releaseDate: String
    let diameter: Double
    let changeCycle, changeCycleRange, pieces: Int
    let function, material: String
    let visionMinimum, visionMaximum, searchCount: Int
}
