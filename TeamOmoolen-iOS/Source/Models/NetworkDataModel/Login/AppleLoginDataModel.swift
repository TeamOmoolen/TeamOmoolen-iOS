//
//  AppleLoginDataModel.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/09.
//

import Foundation

struct AppleLoginDataModel: Codable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = (try? values.decode(String.self, forKey: .accessToken)) ?? ""
    }
}
