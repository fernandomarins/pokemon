//
//  ListViewModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/15/23.
//

import SwiftUI

class ListViewModel: ObservableObject {
    @Published var name: String?
    @Published var abilites: [String]?
    @Published var moves: [String]?
    @Published var fullImage: URL?
    @Published var fullImageShiny: URL?
    
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
