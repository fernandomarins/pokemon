//
//  PokemonModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import Foundation

// MARK: - Breeds
struct Pokemon: Decodable, Identifiable {
    let id: Int
    let sprites: Sprites
    let types: [TypeElement]
    let moves: [Moves]
}

struct Sprites: Decodable {
    let frontDefault: String
    let other: Other
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

struct Other: Decodable {
    let dreamWorld: DreamWorld
    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
    }
}

struct DreamWorld: Decodable {
    let frontDefault: String
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Moves: Decodable, Hashable {
    let move: Move
    
    static func == (lhs: Moves, rhs: Moves) -> Bool {
        lhs.move.name == rhs.move.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(move.name)
    }
}

struct Move: Decodable {
    let name: String
}

struct TypeElement: Decodable {
    let type: Species
}

struct Species: Decodable {
    let name: String
}

// MARK: - Ability
struct Ability: Decodable {
    let ability: Species
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden
        case slot
    }
}

