//
//  PokemonListViewModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import SwiftUI
import Foundation

class PokemonListViewModel: ObservableObject {
    
    @Published var pokemonList = [PokemonList]()
    @Published var pokemonNames = [String]()
    @Published var pokemonCellList = [PokemonCellModel]()
    
    static let storedKey = "pokemon"
    
    let service: APIServiceProtocol
    init(service: APIServiceProtocol = Service()) {
        self.service = service
    }
    
    func fetchPokemonList() async {
        searchStoredData()
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
        UserDefaults.standard.set(convertToData(array: pokemonCellList), forKey: PokemonListViewModel.storedKey)
    }
    
    func searchStoredData() {
        guard let arrayData = UserDefaults.standard.data(forKey: PokemonListViewModel.storedKey),
              let convertedArray: [PokemonCellModel] = convertFromData(data: arrayData),
              !convertedArray.isEmpty else {
            return
        }
        
        pokemonCellList = convertedArray
    }
    
    func createListNames() {
        pokemonList.forEach {
            pokemonNames.append($0.name)
        }
    }
    
    func convertToData<T: Encodable>(array: [T]) -> Data? {
        do {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(array)
            return data
        }
    }
    
    func convertFromData<T: Decodable>(data: Data) -> [T]? {
        do {
            let decoder = JSONDecoder()
            let array = try? decoder.decode([T].self, from: data)
            return array
        }
    }
}
