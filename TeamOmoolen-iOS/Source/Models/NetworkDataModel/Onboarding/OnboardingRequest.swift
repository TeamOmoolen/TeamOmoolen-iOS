//
//  OnboardingRequest.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/05.
//

import Foundation

// MARK: - OnboardingRequest
struct OnboardingRequest: Codable {
    let gender: String
    let age: Int
    let wantedLens: WantedLens
    let suitedLens: SuitedLens
    let wearTime: String
}

// MARK: - SuitedLens
struct SuitedLens: Codable {
    let brand, name: String
}

// MARK: - WantedLens
struct WantedLens: Codable {
    let category, color: [String]
    let function: String
    let changeCycleRange: [Int]
}
