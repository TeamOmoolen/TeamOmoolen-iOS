//
//  SuggestDetailDataModel.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/14.
//

import Foundation

struct SuggestDetailDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SuggestDetailResponse?
    
    enum CodingKeys: String, CodingKey {
        case status
        case success
        case message
        case data
    }
}

struct SuggestDetailResponse: Codable {
    let items: [SuggestItem]
    let totalPage: Int
    
    enum CodingKeys: String, CodingKey {
        case items
        case totalPage
    }
}

struct SuggestItem: Codable {
    let id: String
    let imageList: [String]
    let brand: String
    let name: String
    let diameter: Double
    let changeCycleMinimum: Int
    let changeCycleMaximum: Int
    let pieces: Int
    let price: Int
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
