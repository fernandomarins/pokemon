//
//  PokemonType.swift
//  pokemon
//
//  Created by Fernando Marins on 7/13/23.
//

import Foundation

struct PokemonType: Decodable {
    let damageRelations: DamageRelations
    enum CodingKeys: String, CodingKey {
        case damageRelations = "damage_relations"
    }
}

struct DamageRelations: Decodable {
    let noDamageTo, halfDamageTo, doubleDamageTo, noDamageFrom: [Generation]
    let halfDamageFrom, doubleDamageFrom: [Generation]
    
    enum CodingKeys: String, CodingKey {
        case noDamageTo = "no_damage_to"
        case halfDamageTo = "half_damage_to"
        case doubleDamageTo = "double_damage_to"
        case noDamageFrom = "no_damage_from"
        case halfDamageFrom = "half_damage_from"
        case doubleDamageFrom = "double_damage_from"
    }
}

struct Generation: Decodable {
    let name: String
}
