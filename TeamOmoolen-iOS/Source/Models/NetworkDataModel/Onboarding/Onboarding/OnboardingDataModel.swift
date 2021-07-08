//
//  OnboardingDataModel.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/05.
//

import Foundation

struct OnBoardingDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case success
        case message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
    }
}
