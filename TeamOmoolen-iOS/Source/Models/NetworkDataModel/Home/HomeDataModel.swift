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
    let guides: Guides
    let season: String
    let recommendationBySeason: [RecommendationBy]
    let deadlineEvent: [Event]
    let newLens: NewLens
    let situation: String
    let recommendationBySituation: [RecommendationBySituation]
    let lastestEvent: [Event]
}

// MARK: - Event
struct Event: Codable {
    let id, image: String
}

// MARK: - Guides
struct Guides: Codable {
    let guideList1, guideList2, guideList3: GuideList
}

// MARK: - GuideList
struct GuideList: Codable {
    let category: String
    let guides: [Guide]
}

// MARK: - Guide
struct Guide: Codable {
    let id, question, answer: String
}

// MARK: - RecommendationBySituation
struct RecommendationBySituation: Codable {
    let id, name: String
    let imageList: [String]
    let otherColorList: [String]
    let price: Int
    let brand: String
    let diameter: Double
    let changeCycleMinimum, changeCycleMaximum, pieces: Int
   
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = (try? values.decode(String.self, forKey: .id)) ?? ""
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        imageList = (try? values.decode([String].self, forKey: .imageList)) ?? [""]
        
        otherColorList = (try? values.decode([String].self, forKey: .otherColorList)) ?? [""]
        price = (try? values.decode(Int.self, forKey: .price)) ?? 0
        brand = (try? values.decode(String.self, forKey: .brand)) ?? ""
        
        diameter = (try? values.decode(Double.self, forKey: .name)) ?? 0
        
        changeCycleMinimum = (try? values.decode(Int.self, forKey: .changeCycleMinimum)) ?? 0
        changeCycleMaximum = (try? values.decode(Int.self, forKey: .changeCycleMaximum)) ?? 0
        
        pieces = (try? values.decode(Int.self, forKey: .pieces)) ?? 0
    }
}

// MARK: - RecommendationBy
struct RecommendationBy: Codable {
    let id, name: String
    let imageList: [String]
    let otherColorList: [String]
    let price: Int
    let brand: String
    let diameter: Double
    let changeCycleMinimum, changeCycleMaximum, pieces: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = (try? values.decode(String.self, forKey: .id)) ?? ""
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        imageList = (try? values.decode([String].self, forKey: .imageList)) ?? [""]
        
        otherColorList = (try? values.decode([String].self, forKey: .otherColorList)) ?? [""]
        price = (try? values.decode(Int.self, forKey: .otherColorList)) ?? 0
        brand = (try? values.decode(String.self, forKey: .otherColorList)) ?? ""
        
        diameter = (try? values.decode(Double.self, forKey: .diameter)) ?? 0
        pieces = (try? values.decode(Int.self, forKey: .pieces)) ?? 0
        
        changeCycleMinimum = (try? values.decode(Int.self, forKey: .changeCycleMinimum)) ?? 0
        changeCycleMaximum = (try? values.decode(Int.self, forKey: .changeCycleMaximum)) ?? 0
    }
}

struct NewLens: Codable {
    let newLensBrand1, newLensBrand2, newLensBrand3: [NewLensDetailData]
}
struct NewLensDetailData: Codable {
    let id, name: String
    let imageList: [String]
    let price: Int
    let brand: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = (try? values.decode(String.self, forKey: .id)) ?? ""
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        imageList = (try? values.decode([String].self, forKey: .imageList)) ?? [""]
        
        price = (try? values.decode(Int.self, forKey: .price)) ?? 0
        brand = (try? values.decode(String.self, forKey: .brand)) ?? ""
    }
}
