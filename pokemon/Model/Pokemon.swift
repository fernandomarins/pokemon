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
    let moves: [Moves]
}

struct Sprites: Codable {
    let frontDefault: String
    let other: Other
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

struct Other: Codable {
    let dreamWorld: DreamWorld
    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
    }
}

struct DreamWorld: Codable {
    let frontDefault: String
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Moves: Codable, Hashable {
    let move: Move
    
    static func == (lhs: Moves, rhs: Moves) -> Bool {
        lhs.move.name == rhs.move.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(move.name)
    }
}

struct Move: Codable {
    let name: String
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

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Species
}

