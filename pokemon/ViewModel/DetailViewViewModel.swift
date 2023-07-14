//
//  DetailViewViewModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/13/23.
//

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
                        
                        var weakAgainstList = [String]()
                        var strongAgainstList = [String]()
                        
                        let appendNamesToWeakList = { (names: [String]) in
                            weakAgainstList.append(contentsOf: names)
                        }
                        
                        let appendNamesToStrongList = { (names: [String]) in
                            strongAgainstList.append(contentsOf: names)
                        }
                        
                        appendNamesToWeakList(damageRelations.noDamageTo.map(\.name))
                        appendNamesToWeakList(damageRelations.doubleDamageFrom.map(\.name))
                        
                        appendNamesToStrongList(damageRelations.doubleDamageTo.map(\.name))
                        appendNamesToStrongList(damageRelations.noDamageFrom.map(\.name))
                        
                        var strongTypesList = [UIImage]()
                        var weakTypesList = [UIImage]()
                        
                        self?.createImagesList(arrayString: weakAgainstList, arrayImage: &weakTypesList)
                        self?.createImagesList(arrayString: strongAgainstList, arrayImage: &strongTypesList)
                        
                        self?.pokemonDetailModel = PokemonDetailModel(
                            weakList: weakAgainstList,
                            weakImages: weakTypesList,
                            strongList: strongAgainstList,
                            strongImages: strongTypesList
                        )
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        } catch {
//            checkIfEmpty()
            print(error)
        }
    }
    
    private func createImagesList(arrayString: [String], arrayImage: inout [UIImage]) {
        arrayString.forEach {
            let image = UIImage(named: $0) ?? UIImage()
            arrayImage.append(image)
        }
        
//        weakAgainstList.forEach {
//            let image = UIImage(named: $0)  ?? UIImage()
//            weakTypesList.append(image)
//        }
    }
    
//    private func checkIfEmpty() {
//        DispatchQueue.main.async {
//            self.isEmptyStrong = self.strongAgainstList.isEmpty
//            self.isEmptyWeak = self.weakAgainstList.isEmpty
//        }
//    }
}
