//
//  ListViewModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/15/23.
//

import SwiftUI

class ListViewModel: ObservableObject {
    var name: String?
    var abilites: [String]?
    var moves: [String]?
    var fullImage: URL?
    var fullImageShiny: URL?
    
    var isMoveEmpty: Bool {
        moves?.isEmpty ?? true
    }
    
    init(name: String? = nil, abilites: [String]? = nil, moves: [String]? = nil, fullImage: URL? = nil, fullImageShiny: URL? = nil) {
        self.name = name
        self.abilites = abilites
        self.moves = moves
        self.fullImage = fullImage
        self.fullImageShiny = fullImageShiny
    }
}
