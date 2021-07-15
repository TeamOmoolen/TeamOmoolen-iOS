//
//  SearchFilterRequest.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/09.
//

import Foundation

struct SearchFilterRequest: Codable {
    let brand: [String]
    let color: [String]
    let diameter: Int
    let changeCycleRange: [Int]
    
    enum CodingKeys: String, CodingKey {
        case brand
        case color
        case diameter
        case changeCycleRange
    }
    
    init(_ brand: [String], _ color: [String], _ diameter: Int, _ changeCycleRange: [Int]) {
        self.brand = brand
        self.color = color
        self.diameter = diameter
        self.changeCycleRange = changeCycleRange
    }
}
