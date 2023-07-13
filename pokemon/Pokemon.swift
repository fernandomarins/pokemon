//
//  PokemonModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import Foundation

// MARK: - Breeds
struct Pokemon: Codable, Identifiable {
    let id: Int
    let sprites: Sprites
    let types: [TypeElement]
}

struct Sprites: Codable {
    let frontDefault: String
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct TypeElement: Codable {
    let type: Species
}

struct Species: Codable {
    let name: String
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

