//
//  PokemonModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import Foundation

// MARK: - Breeds
struct Pokemon: Codable {
    let sprites: Sprites
}

class Sprites: Codable {
    let frontDefault: String
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Ability
struct Ability: Codable {
    let ability: Species
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden
        case slot
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}

// MARK: - GameIndex
struct GameIndex: Codable {
    let gameIndex: Int
    let version: Species

    enum CodingKeys: String, CodingKey {
        case gameIndex
        case version
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault, frontShiny: String
}

// MARK: - Other
struct Other: Codable {
    let officialArtwork: OfficialArtwork
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Species
}

