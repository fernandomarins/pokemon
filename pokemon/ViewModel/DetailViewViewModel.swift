//
//  DetailViewViewModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/13/23.
//

import Foundation
import SwiftUI

class DetailViewViewModel: ObservableObject {
    static let storedKey = "pokemonDetail"
    
    @Published var pokemonDetailModel: PokemonDetailModel?
    
    let service: APIServiceProtocol
    init(service: APIServiceProtocol = Service()) {
        self.service = service
    }
    
    func fetchPokemonType(id: Int?) async {
        await searchStoredData { [weak self] in
            if $0 {
                guard let id = id else { return }
                do {
                    try await self?.service.fetchType(id: String(id)) { [weak self] result in
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
}

extension DetailViewViewModel {
    func storeData() {
        UserDefaults.standard.set(convertObjectToData(object: pokemonDetailModel), forKey: DetailViewViewModel.storedKey)
    }
    
    func searchStoredData(continueHandler: @escaping (Bool) async -> Void) async {
        guard let data = UserDefaults.standard.data(forKey: DetailViewViewModel.storedKey),
              let convertedData: PokemonDetailModel = convertObjectFromData(data: data) else {
            await continueHandler(true)
            return
        }
        
        DispatchQueue.main.async {  [weak self] in
            self?.pokemonDetailModel = convertedData
        }
        await continueHandler(false)
    }
}
