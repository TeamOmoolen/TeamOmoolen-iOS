//
//  SuggestDataModel.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/14.
//

import Foundation

struct SuggestDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SuggestResponse?
    
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
        data = (try? values.decode(SuggestResponse.self, forKey: .data)) ?? nil
    }
}

struct SuggestResponse: Codable {
    let SuggestForYou: SuggestProduct
    let SuggestForSituation: SuggestProduct
    let SuggestForNew: SuggestProduct
    let suggestForSeason: SuggestProduct
    
    enum CodingKeys: String, CodingKey {
        case SuggestForYou
        case SuggestForSituation
        case SuggestForNew
        case suggestForSeason
    }
}

struct SuggestProduct: Codable {
    let id: String
    let imageList: [String]
    let brand,name: String
    let diameter: Double
    let changeCycle,pieces,price: Int
    let otherColorList: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageList
        case brand
        case name
        case diameter
        case changeCycle
        case pieces
        case price
        case otherColorList
    }
}
