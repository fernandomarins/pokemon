//
//  PokemonList.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import Foundation

struct PokemonResult: Decodable {
    let results: [PokemonList]
}

struct PokemonList: Decodable, Hashable {
    let name: String
    let url: String
}
