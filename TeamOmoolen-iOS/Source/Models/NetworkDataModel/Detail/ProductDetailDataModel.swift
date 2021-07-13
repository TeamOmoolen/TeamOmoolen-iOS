//
//  ProductDetailDataModel.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/13.
//

import Foundation

import Foundation
struct ProductDetailDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ProductDetailResponse?
    
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
        data = (try? values.decode(ProductDetailResponse.self, forKey: .data)) ?? nil
    }
}

struct ProductDetailResponse: Codable {
    let imageURL: [String]
    let brand: String
    let name: String
    let price: Int
    let diameter: Double
    let changeCycle: Int
    let material: String
    let function: String
    let color: String
    let otherColorList: [String]
    let suggestList: [SuggestList]
    let popularList: [PopularList]
}
struct SuggestList: Codable {
    let id: String
    let imageList: [String]
    let brand: String
    let name: String
    let diameter: Double
    let changeCycle: Int
    let pieces: Int
    let price: Int
    let otherColorList: [String]
}
struct PopularList: Codable {
    let id: String
    let imageList: [String]
    let brand: String
    let name: String
    let diameter: Double
    let changeCycle: Int
    let pieces: Int
}
