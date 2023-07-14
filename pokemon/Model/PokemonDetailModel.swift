//
//  PokemonDetailModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/14/23.
//

import UIKit

struct PokemonDetailModel {
    let weakList: [String]
    let weakImages: [UIImage]
    let strongList: [String]
    let strongImages: [UIImage]
    
    var isWeakEmpty: Bool {
        weakList.isEmpty
    }
    
    var isStrongEmpty: Bool {
        strongList.isEmpty
    }
}
