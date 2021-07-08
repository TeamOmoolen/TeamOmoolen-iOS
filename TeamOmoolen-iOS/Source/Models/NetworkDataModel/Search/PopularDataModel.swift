//
//  PopularDataModel.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/08.
//

import Foundation

struct PopularDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: PopularResponse
    
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
        data = (try? values.decode(PopularResponse.self, forKey: .data)) ?? PopularResponse(popular: "", lank: 0)
    }
    
    struct PopularResponse: Codable {
        let popular: String
        let lank: Int
        
        enum CodingKeys: String, CodingKey {
            case popular
            case lank
        }
    }
}
