//
//  DetailDataModel.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/11.
//

import Foundation

struct DetailDataModel {
    var brandName: String
    var lensName: String
    var price: Int
    var diameter: Double
    var cycle: Int
    var texture: String
    var function: String
    var colorList: [String]
    
    var silmilarList: [RecommendLensDataModel]
    var newList: [RecommendLensDataModel]
}

struct DetailMainDataModel {
    var brandName: String
    var lensName: String
    var price: Int
    var diameter: Double
    var cycle: Int
    var texture: String
    var function: String
    var colorList: [String]
}
