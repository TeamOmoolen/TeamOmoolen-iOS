//
//  AppleLoginDataModel.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/09.
//

import Foundation

struct AppleLoginRequest: Codable {
    let oauthKey: String
    let familyName: String
    let givenName: String
    
    init(_ userIdentifier: String, _ familyName: String, _ givenName: String) {
        self.oauthKey = userIdentifier
        self.familyName = familyName
        self.givenName = givenName
    }
}
