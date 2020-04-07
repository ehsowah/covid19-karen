//
//  DataModel.swift
//  Covid19
//
//  Created by sowah on 4/5/20.
//  Copyright © 2020 sowah. All rights reserved.
//

import Foundation

struct MyPost: Codable {
    var response: [InnerItems]
}

struct InnerItems: Codable {
    let country: String
    let cases: Cases
    let deaths: Deaths
//    let tests: Tests
    let day: String
    let time: String
}

struct Cases: Codable {
//    let new: String
    let active: Int
    let critical: Int
    let recovered: Int
    let total: Int
}

struct Deaths: Codable {
//    let new: String
    let total: Int
}

struct Tests: Codable {
    let total: Bool
}
