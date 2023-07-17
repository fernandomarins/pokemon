//
//  DetailViewViewModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/13/23.
//

import Foundation
import SwiftUI

class DetailViewViewModel: ObservableObject {
    @Published var pokemonDetailModel: PokemonDetailModel?
    
    let service: APIServiceProtocol
    init(service: APIServiceProtocol = Service()) {
        self.service = service
    }
    
    func fetchPokemonType(id: Int?) async {
        guard let id = id else { return }
        do {
            try await service.fetchType(id: String(id)) { [weak self] result in
                switch result {
                case .success(let pokemon):
                    DispatchQueue.main.async { [weak self] in
                        let damageRelations = pokemon.damageRelations
                        
                        let weakAgainstList = damageRelations.noDamageTo.map(\.name) + damageRelations.doubleDamageFrom.map(\.name)
                        let strongAgainstList = damageRelations.doubleDamageTo.map(\.name) + damageRelations.noDamageFrom.map(\.name)
                        
                        self?.pokemonDetailModel = PokemonDetailModel(
                            weakList: weakAgainstList,
                            strongList: strongAgainstList
                        )
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error)
        }
    }
}
