//
//  OnboardingRequest.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/07/05.
//

import Foundation

struct OnboardingRequest: Codable {
    let gender: String
    let age: String
    let lensKind: [String]
    let lensColor: [String]
    let lensFunction: String
    let lensPeriod: String
    let lensBrand: String
    let lensName: String
    let lensWhen: String
    
    let userIdentifier: String
    
    init(_ gender: String, _ age: String, _ lensKind: [String], _ lensColor: [String], _ lensFunction: String, _ lensPeriod: String, _ lensBrand: String, _ lensName: String, _ lensWhen: String, _ userIdentifier: String) {
        self.gender = gender
        self.age = age
        self.lensKind = lensKind
        self.lensColor = lensColor
        self.lensFunction = lensFunction
        self.lensPeriod = lensPeriod
        self.lensBrand = lensBrand
        self.lensName = lensName
        self.lensWhen = lensWhen
        
        self.userIdentifier = userIdentifier
    }
}
