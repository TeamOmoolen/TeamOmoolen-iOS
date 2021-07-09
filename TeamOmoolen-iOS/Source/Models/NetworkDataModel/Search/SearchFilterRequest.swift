//
//  SearchFilterRequest.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/09.
//

import Foundation

struct SearchFilterRequest: Codable {
    let lensBrand: [String]
    let lensColor: [String]
    let lensDiameter: Int
    let lensCycle: [Int]
    
    enum CodingKeys: String, CodingKey {
        case lensBrand = "brand"
        case lensColor = "color"
        case lensDiameter = "diameter"
        case lensCycle = "changeCycle"
    }
    
    init(_ lensBrand: [String], _ lensColor: [String], _ lensDiameter: Int, _ lensCycle: [Int]) {
        self.lensBrand = lensBrand
        self.lensColor = lensColor
        self.lensDiameter = lensDiameter
        self.lensCycle = lensCycle
    }
}
