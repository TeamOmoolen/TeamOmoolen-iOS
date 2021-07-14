//
//  HomeRequest.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/06.
//

import Foundation

// MARK: - HomeDataModel
struct HomeDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: HomeResponse?
    
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
        data = (try? values.decode(HomeResponse.self, forKey: .data)) ?? nil
    }
}

// MARK: - DataClass
struct HomeResponse: Codable {
    let username: String
    let recommendationByUser: [RecommendationBy]
    let guides: [Guide]
    let season: String
    let recommendationBySeason: [RecommendationBy]
    let deadlineEvent: [Event]
    let newLens: [NewLens]
    let situation: String
    let recommendationBySituation: [RecommendationBySituation]
    let lastestEvent: [Event]
}

// MARK: - Event
struct Event: Codable {
    let id, title, content, image: String
    let endDate, startDate, createAt, updateAt: String
    let deleteAt: String
}

// MARK: - Guide
struct Guide: Codable {
    let id, question, answer, createAt: String
    let updateAt, deleteAt: String
}

// MARK: - RecommendationBySituation
struct RecommendationBySituation: Codable {
    let id, name: String
    let imageList: [String]
    let category, color: String
    let otherColorList: [String]
    let price: Int
    let brand, releaseDate: String
    let diameter: Double
    let changeCycleRange, pieces, minCycle, maxCycle: Int
    let function: String
    let visionMinimum, visionMaximum, searchCount: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = (try? values.decode(String.self, forKey: .id)) ?? ""
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        imageList = (try? values.decode([String].self, forKey: .imageList)) ?? [""]
        category = (try? values.decode(String.self, forKey: .category)) ?? ""
        color = (try? values.decode(String.self, forKey: .color)) ?? ""
        otherColorList = (try? values.decode([String].self, forKey: .otherColorList)) ?? [""]
        price = (try? values.decode(Int.self, forKey: .price)) ?? 0
        brand = (try? values.decode(String.self, forKey: .brand)) ?? ""
        releaseDate = (try? values.decode(String.self, forKey: .name)) ?? ""
        diameter = (try? values.decode(Double.self, forKey: .name)) ?? 0
        changeCycleRange = (try? values.decode(Int.self, forKey: .name)) ?? 0
        pieces = (try? values.decode(Int.self, forKey: .pieces)) ?? 0
        minCycle = (try? values.decode(Int.self, forKey: .minCycle)) ?? 0
        maxCycle = (try? values.decode(Int.self, forKey: .maxCycle)) ?? 0
        function = (try? values.decode(String.self, forKey: .function)) ?? ""
        visionMinimum = (try? values.decode(Int.self, forKey: .visionMinimum)) ?? 0
        visionMaximum = (try? values.decode(Int.self, forKey: .visionMaximum)) ?? 0
        searchCount = (try? values.decode(Int.self, forKey: .searchCount)) ?? 0
    }
}

// MARK: - RecommendationBy
struct RecommendationBy: Codable {
    let id, name: String
    let imageList: [String]
    let category, color: String
    let otherColorList: [String]
    let price: Int
    let brand, releaseDate: String
    let diameter: Double
    let pieces: Int
    let minCycle, maxCycle, changeCycleRange: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        
        id = (try? values.decode(String.self, forKey: .id)) ?? ""
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        imageList = (try? values.decode([String].self, forKey: .imageList)) ?? [""]
        category = (try? values.decode(String.self, forKey: . category)) ?? ""
        color = (try? values.decode(String.self, forKey: .color)) ?? ""
        otherColorList = (try? values.decode([String].self, forKey: .otherColorList)) ?? [""]
        price = (try? values.decode(Int.self, forKey: .otherColorList)) ?? 0
        brand = (try? values.decode(String.self, forKey: .otherColorList)) ?? ""
        releaseDate = (try? values.decode(String.self, forKey: .otherColorList)) ?? ""
        diameter = (try? values.decode(Double.self, forKey: .diameter)) ?? 0
        pieces = (try? values.decode(Int.self, forKey: .pieces)) ?? 0
        minCycle = (try? values.decode(Int.self, forKey: .minCycle)) ?? 0
        maxCycle = (try? values.decode(Int.self, forKey: .maxCycle)) ?? 0
        changeCycleRange = (try? values.decode(Int.self, forKey: .changeCycleRange)) ?? 0
        
    }
}

struct NewLens: Codable {
    let mainData: [NewLensDetailData]
    
    
}
struct NewLensDetailData: Codable {
    let id, name: String
    let imageList: [String]
    let category, color: String
    let otherColorList: [String]
    let price: Int
    let brand, releaseDate: String
    let diameter: Double
    let changeCycleRange, pieces, minCycle, maxCycle: Int
    let function: String
    let visionMinimum, visionMaximum, searchCount: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        
        id = (try? values.decode(String.self, forKey: .id)) ?? ""
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        imageList = (try? values.decode([String].self, forKey: .imageList)) ?? [""]
        category = (try? values.decode(String.self, forKey: . category)) ?? ""
        color = (try? values.decode(String.self, forKey: .color)) ?? ""
        otherColorList = (try? values.decode([String].self, forKey: .otherColorList)) ?? [""]
        price = (try? values.decode(Int.self, forKey: .otherColorList)) ?? 0
        brand = (try? values.decode(String.self, forKey: .otherColorList)) ?? ""
        releaseDate = (try? values.decode(String.self, forKey: .otherColorList)) ?? ""
        diameter = (try? values.decode(Double.self, forKey: .diameter)) ?? 0
        pieces = (try? values.decode(Int.self, forKey: .pieces)) ?? 0
        minCycle = (try? values.decode(Int.self, forKey: .minCycle)) ?? 0
        maxCycle = (try? values.decode(Int.self, forKey: .maxCycle)) ?? 0
        changeCycleRange = (try? values.decode(Int.self, forKey: .changeCycleRange)) ?? 0
        function = (try? values.decode(String.self, forKey: .function)) ?? ""
        visionMinimum = (try? values.decode(Int.self, forKey: .visionMinimum)) ?? 0
        visionMaximum = (try? values.decode(Int.self, forKey: .visionMaximum)) ?? 0
        searchCount = (try? values.decode(Int.self, forKey: .searchCount)) ?? 0
    }
}
