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
    let data: [SearchResultResponse]
    
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
        data = (try? values.decode([SearchResultResponse].self, forKey: .data)) ?? [SearchResultResponse(brandName: "", lensName: "", diameter: 0, cycle: "", price: 0)]
    }
}

struct SearchResultResponse: Codable {
    let brandName: String
    let lensName: String
    let diameter: Float
    let cycle: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case brandName
        case lensName
        case diameter
        case cycle
        case price
    }
    
}
