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
    
    enum CodingKeys: String, CodingKey {
        case products
    }
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let name: String
    let imageList: [String]
    let category: String
    let color: Int
    let otherColorList: [Int]
    let price: Int
    let brand, releaseDate: String
    let diameter: Double
    let changeCycle, pieces: Int
    let function: String
    let visionMinimum, visionMaximum, searchCount: Int
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case imageList
//        case category
//        case color
//        case otherColorList
//        case price
//        case brand
//        case releaseData
//        case diameter
//        case changeCycle
//        case pieces
//        case function
//        case visionMinimum
//        case visionMaximum
//        case searchCount
//    }
}
