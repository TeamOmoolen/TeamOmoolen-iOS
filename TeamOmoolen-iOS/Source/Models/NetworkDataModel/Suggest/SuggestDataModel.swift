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
    let suggestForYou: [SuggestProduct]
    let suggestForSituation: [SuggestProduct]
    let suggestForNew: [SuggestProduct]
    let suggestForSeason: [SuggestProduct]
    let season: String
    let situation: String
    let suggestForYouTotalPage: Int
    let suggestForSituationTotalPage: Int
    let suggestForNewTotalPage: Int
    let suggestForSeasonTotalPage: Int
    
    enum CodingKeys: String, CodingKey {
        case suggestForYou
        case suggestForSituation
        case suggestForNew
        case suggestForSeason
        case season
        case situation
        case suggestForYouTotalPage
        case suggestForSituationTotalPage
        case suggestForNewTotalPage
        case suggestForSeasonTotalPage
    
    }
}

struct SuggestProduct: Codable {
    let id: String
    let imageList: [String]
    let brand,name: String
    let diameter: Double
    let changeCycleMinimum,changeCycleMaximum,pieces,price: Int
    let otherColorList: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageList
        case brand
        case name
        case diameter
        case changeCycleMinimum
        case changeCycleMaximum
        case pieces
        case price
        case otherColorList
    }
}
