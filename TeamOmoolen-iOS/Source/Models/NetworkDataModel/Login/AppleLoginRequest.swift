//
//  AppleLoginDataModel.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/09.
//

import Foundation

struct AppleLoginRequest: Codable {
    let email: String
    let familyName: String
    let givenName: String
    
    init(_ email: String, _ familyName: String, _ givenName: String) {
        self.email = email
        self.familyName = familyName
        self.givenName = givenName
    }
}
