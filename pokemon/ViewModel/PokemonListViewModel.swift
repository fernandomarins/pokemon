//
//  PokemonListViewModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import SwiftUI
import Foundation

class PokemonListViewModel: ObservableObject {
    static let storedKey = "pokemon"
    
    @Published var pokemonList = [PokemonList]()
    @Published var pokemonNames = [String]()
    @Published var pokemonCellList = [PokemonCellModel]()
    @Published var number = "" {
        didSet {
            Task {
                await fetchPokemonList(number: number)
                await fetchPokemonURL()
            }
            
        }
    }
    
    let service: APIServiceProtocol
    init(service: APIServiceProtocol = Service()) {
        self.service = service
    }
    
    func fetchPokemonList(number: String = "151") async {
        DispatchQueue.main.async {
            self.pokemonList.removeAll()
            self.pokemonNames.removeAll()
            self.pokemonCellList.removeAll()
        }
        print("------------ COMEÇO ----------------")
        print("número pokemonLinst: ", pokemonList.count)
        print("número pokemonNames: ", pokemonNames.count)
        print("número pokemonCellList: ", pokemonCellList.count)
        print("------------ COMEÇO ----------------")
        UserDefaults.standard.removeObject(forKey: PokemonListViewModel.storedKey)
        await searchStoredData { [weak self] in
            guard let self = self else { return }
            if $0 {
                do {
                    try await self.service.fetchList(number: number) { [weak self] result in
                        guard let self = self else { return }
                        switch result {
                        case .success(let list):
                            DispatchQueue.main.async { [weak self] in
                                self?.pokemonList = list.results
                                self?.createListNames { _ in
                                    Task {
                                        await self?.fetchPokemonURL()
                                    }
                                }
                            }
                            print("------------ FIM ----------------")
                            print("número pokemonLinst: ", self.pokemonList.count)
                            print("número pokemonNames: ", self.pokemonNames.count)
                            print("número pokemonCellList: ", self.pokemonCellList.count)
                            print("------------ FIM ----------------")
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
    
    func fetchPokemonURL() async {
        print("número pokemonNames dentro de fetchURL: ", pokemonNames.count)
        for name in pokemonNames {
            do {
                try await service.fetchItem(name: name) { [weak self] result in
                    switch result {
                    case .success(let item):
                        if let url = URL(string: item.sprites.frontDefault),
                           let fullImageUrl = URL(string: item.sprites.other.home.frontDefault),
                           let fullImageShinyUrl = URL(string: item.sprites.other.home.frontShiny) {
                            let pokemon = PokemonCellModel(
                                name: name,
                                type: item.types[0].type.name,
                                image: url,
                                index: item.id,
                                moves: item.moves,
                                fullImage: fullImageUrl,
                                fullImageShiny: fullImageShinyUrl
                            )
                            DispatchQueue.main.async { [weak self] in
                                self?.pokemonCellList.append(pokemon)
                            }
                            self?.storeData()
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

private extension PokemonListViewModel {
    func storeData() {
        UserDefaults.standard.set(convertObjectToData(object: pokemonCellList), forKey: PokemonListViewModel.storedKey)
    }
    
    func searchStoredData(continueHandler: @escaping (Bool) async -> Void) async {
        guard let arrayData = UserDefaults.standard.data(forKey: PokemonListViewModel.storedKey),
              let convertedArray: [PokemonCellModel] = convertObjectFromData(data: arrayData),
              !convertedArray.isEmpty else {
            await continueHandler(true)
            return
        }
        
        DispatchQueue.main.async {  [weak self] in
            self?.pokemonCellList = convertedArray
        }
        await continueHandler(false)
    }
    
    func createListNames(completionHandler: @escaping (Bool) -> Void) {
        print("------------ COMEÇO ----------------")
        print("número pokemonList dentro de CREATELIST: ", pokemonList.count)
        print("número pokemonNames dentro de CREATELIST: ", pokemonNames.count)
        print("------------ COMEÇO ----------------")
        pokemonList.forEach {
            pokemonNames.append($0.name)
        }
        print("------------ FIM ----------------")
        print("número pokemonList dentro de CREATELIST: ", pokemonList.count)
        print("número pokemonNames dentro de CREATELIST: ", pokemonNames.count)
        print("------------ FIM ----------------")
        completionHandler(true)
        
    }
}
