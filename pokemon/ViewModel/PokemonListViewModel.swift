//
//  PokemonListViewModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import SwiftUI

class PokemonListViewModel: ObservableObject {
    
    @Published var pokemonList = [PokemonList]()
    @Published var pokemonNames = [String]()
    @Published var pokemonCellList = [PokemonCellModel]()
    
    let service: APIServiceProtocol
    init(service: APIServiceProtocol = Service()) {
        self.service = service
    }
    
    func fetchPokemonList() async {
        do {
            try await service.fetchList { [weak self] result in
                switch result {
                case .success(let list):
                    DispatchQueue.main.async { [weak self] in
                        self?.pokemonList = list.results
                        self?.createListNames()
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func fetchPokemonURL() async {
        for name in pokemonNames {
            do {
                try await service.fetchItem(name: name) { result in
                    switch result {
                    case .success(let item):
                        if let url = URL(string: item.sprites.frontDefault) {
                            let pokemon = PokemonCellModel(
                                name: name,
                                type: item.types[0].type.name,
                                image: url
                            )
                            DispatchQueue.main.async { [weak self] in
                                self?.pokemonCellList.append(pokemon)
                            }
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

    private func createListNames() {
        pokemonList.forEach {
            pokemonNames.append($0.name)
        }
    }
}
