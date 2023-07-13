//
//  PokemonCellModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/13/23.
//

import UIKit

struct PokemonCellModel: Hashable {
    let name: String
    let type: String
    let image: URL
    let index: Int
    let moves: [Moves]
    let fullImage: URL
    
    static func == (lhs: PokemonCellModel, rhs: PokemonCellModel) -> Bool {
        lhs.index == rhs.index
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(index)
    }
}
