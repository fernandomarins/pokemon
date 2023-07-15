//
//  PokemonDetailModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/14/23.
//

import UIKit

struct PokemonDetailModel: Codable {
    let weakList: [String]
    let strongList: [String]
    
    var isWeakEmpty: Bool {
        weakList.isEmpty
    }
    
    var isStrongEmpty: Bool {
        strongList.isEmpty
    }
}
