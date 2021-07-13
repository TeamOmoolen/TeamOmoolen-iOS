//
//  NewLens.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import Foundation

struct NewLensDataModel {
    var brandName: String
    var detailData: [NewLensDetailDataModel]
}

struct NewLensDetailDataModel {
    var lensImage: [String]
    var brandName: String
    var lensName: String
    var price: Int
}
