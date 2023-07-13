//
//  PokemonListViewModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import SwiftUI

class PokemonListViewModel: ObservableObject {
    @Published var pokemons = [PokemonList]()
    @Published var pokemonNames = [String]()
    @Published var pokemonImageURLs = [URL]()
    
    let service = Service()
    
    func fetchPokemonList() async {
        do {
            try await service.fetchList { [weak self] result in
                switch result {
                case .success(let list):
                    DispatchQueue.main.async { [weak self] in
                        self?.pokemons = list.results
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
    
    func createListNames() {
        pokemons.forEach {
            pokemonNames.append($0.name)
        }
    }
    
    func fetchPokemonURL() async {
        await withTaskGroup(of: Void.self) { group in
            for name in pokemonNames {
                group.addTask { [weak self] in
                    guard let self = self else { return }
                    do {
                        try await self.service.fetchItem(name: name) { result in
                            switch result {
                            case .success(let pokemon):
                                if let url = URL(string: pokemon.sprites.frontDefault) {
                                    DispatchQueue.main.async {
                                        self.pokemonImageURLs.append(url)
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
        }
    }
}
