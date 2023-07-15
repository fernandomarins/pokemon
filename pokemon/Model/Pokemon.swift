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
    let abilities: [Ability]
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
    let home: Home
    enum CodingKeys: String, CodingKey {
        case home
    }
}

struct Home: Decodable {
    let frontDefault: String
    let frontShiny: String
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
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

struct Ability: Codable {
    let ability: [String: String]
}

struct Move: Codable {
    let name: String
}

struct TypeElement: Decodable {
    let type: Species
}

struct Species: Decodable {
    let name: String
}

