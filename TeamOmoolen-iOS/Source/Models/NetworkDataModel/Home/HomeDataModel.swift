//
//  HomeRequest.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/06.
//

import Foundation

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
    let findRecomendationByUser: [FindRecomendationByUser]
    let guides: [Guide]
    let season: String
    let recommendationBySeason: [FindRecomendationByUser]
    let deadlineEvent: [Event]
    let newLens: NewLens
    let situation: String
    let recommendationBySituation: [FindRecomendationByUser]
    let lastestEvent: [Event]

    enum CodingKeys: String, CodingKey {
        case username
        case findRecomendationByUser
        case guides
        case season
        case recommendationBySeason
        case deadlineEvent
        case newLens
        case situation
        case recommendationBySituation
        case lastestEvent
    }
}

// MARK: - Event
struct Event: Codable {
    let id: Int
    let title, content, image: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case image
    }
}

// MARK: - FindRecomendationByUser
struct FindRecomendationByUser: Codable {
    let id: Int
    let name: String
    let imageList: [String]
    let category: String
    let color, price: Int
    let brand: String
    let releaseDate: String
    let diameter: Double
    let changeCycle, pieces: Int
    let otherColorList: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageList
        case category
        case color
        case price
        case brand
        case releaseDate
        case diameter
        case changeCycle
        case pieces
        case otherColorList
    }
}

// MARK: - Guide
struct Guide: Codable {
    let id: Int
    let question, answer: String

    enum CodingKeys: String, CodingKey {
        case id
        case question
        case answer
    }
}

// MARK: - NewLens
struct NewLens: Codable {
    let brand1, brand2, brand3: [FindRecomendationByUser]

    enum CodingKeys: String, CodingKey {
        case brand1
        case brand2
        case brand3
    }
}
