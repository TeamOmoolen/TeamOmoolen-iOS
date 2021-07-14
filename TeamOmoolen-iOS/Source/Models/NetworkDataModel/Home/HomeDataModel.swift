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
    let newLens: [RecommendationBySituation]
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
    let changeCycleRange, pieces: Int
    let function: String
    let visionMinimum, visionMaximum, searchCount: Int
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
    let changeCycle, changeCycleRange: Int
}

