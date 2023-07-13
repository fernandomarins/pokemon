//
//  PokemonListViewModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import SwiftUI

class PokemonListViewModel: ObservableObject {
    @Published var pokemons = [PokemonList]()
    
    let service = Service()
    
    func fetchPokemonList() async {
        do {
            try await service.fetchList { result in
                switch result {
                case .success(let list):
                    DispatchQueue.main.async { [weak self] in
                        self?.pokemons = list.results
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
