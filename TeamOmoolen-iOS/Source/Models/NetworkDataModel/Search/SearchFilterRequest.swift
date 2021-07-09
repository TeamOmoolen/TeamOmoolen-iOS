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
    let lensDiameter: [String]
    let lensCycle: [String]
    
    let userIdentifier: String
    
    init(_ lensBrand: [String], _ lensColor: [String], _ lensDiameter: [String], _ lensCycle: [String], _ userIdentifier: String) {
        self.lensBrand = lensBrand
        self.lensColor = lensColor
        self.lensDiameter = lensDiameter
        self.lensCycle = lensCycle
        
        self.userIdentifier = userIdentifier
    }
}
