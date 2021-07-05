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
    let data: OnboardingResponse
    
    enum CodingKeys: String, CodingKey {
        case status
        case success
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = (try? values.decode(OnboardingResponse.self, forKey: .data)) ?? OnboardingResponse()
        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
    }
}
// MARK: - Onboarding
struct OnboardingResponse: Codable {
    // 큐레이팅이 들어가면 됨.
//    let gender: String
//    let age: String
//    let lensKind: String
//    let lensColor: String
//    let lensFunction: String
//    let lensPeriod: String
//    let lensBrand: String
//    let lensName: String
//    let lensWhen: String
//
//    enum CodingKeys: String, CodingKey {
//        case gender, age, lensKind, lensColor, lensFunction, lensPeriod, lensBrand, lensName, lensWhen
//    }
}
