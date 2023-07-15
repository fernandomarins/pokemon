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
        guard let id = id else { return }
        do {
            try await service.fetchType(id: String(id)) { [weak self] result in
                switch result {
                case .success(let pokemon):
                    DispatchQueue.main.async { [weak self] in
                        let damageRelations = pokemon.damageRelations
                        
                        let weakAgainstList = damageRelations.noDamageTo.map(\.name) + damageRelations.doubleDamageFrom.map(\.name)
                        let strongAgainstList = damageRelations.doubleDamageTo.map(\.name) + damageRelations.noDamageFrom.map(\.name)
                        
                        let weakTypesList = weakAgainstList.compactMap { UIImage(named: $0) }
                        let strongTypesList = strongAgainstList.compactMap { UIImage(named: $0) }
                        
                        self?.pokemonDetailModel = PokemonDetailModel(
                            weakList: weakAgainstList,
                            weakImages: weakTypesList ,
                            strongList: strongAgainstList,
                            strongImages: strongTypesList
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

extension DetailViewViewModel {
    func storeData() {
//        UserDefaults.standard.set(convertObjectToData(object: pokemonDetailModel), forKey: DetailViewViewModel.storedKey)
    }
    
//    func searchStoredData() {
//        guard let data = UserDefaults.standard.data(forKey: DetailViewViewModel.storedKey),
//              let convertedData: [PokemonDetailModel] = convertObjectFromData(data: data),
//              !convertedArray.isEmpty else {
//            return
//        }
//        
//        DispatchQueue.main.async {  [weak self] in
//            self?.pokemonCellList = convertedArray
//        }
//    }
}
