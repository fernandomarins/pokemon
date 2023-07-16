//
//  StatsViewModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/15/23.
//

import SwiftUI

class StatsViewModel: ObservableObject {
    var name: String?
    var fullImage: URL?
    var fullImageShiny: URL?
    
    var statsDict: [String: Int]? {
        createStats(stats: stats ?? [])
    }
    
    let stats: [StatElement]?
    
    init(name: String? = nil, stats: [StatElement]? = nil, fullImage: URL? = nil, fullImageShiny: URL? = nil) {
        self.name = name
        self.stats = stats
        self.fullImage = fullImage
        self.fullImageShiny = fullImageShiny
    }
}

private extension StatsViewModel {
    func createStats(stats: [StatElement]) -> [String: Int] {
        return stats.reduce(into: [:]) { dict, stat in
            dict[stat.stat.name] = stat.baseStat
        }
    }
}
