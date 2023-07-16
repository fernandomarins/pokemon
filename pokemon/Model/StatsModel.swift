//
//  StatsModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/15/23.
//

import Foundation

// MARK: - StatElement
struct StatElement: Codable {
    let baseStat: Int
    let stat: Stat

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

// MARK: - StatStat
struct Stat: Codable {
    let name: String
}
