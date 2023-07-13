//
//  DetailViewViewModel.swift
//  pokemon
//
//  Created by Fernando Marins on 7/13/23.
//

import SwiftUI

class DetailViewViewModel: ObservableObject {
    private var weakAgainstList = [String]()
    private var strongAgainstList = [String]()
    @Published var strongTypesList = [UIImage]()
    @Published var weakTypesList = [UIImage]()
    
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
                        
                        let appendNamesToWeakList = { (names: [String]) in
                            self?.weakAgainstList.append(contentsOf: names)
                        }
                        
                        let appendNamesToStrongList = { (names: [String]) in
                            self?.strongAgainstList.append(contentsOf: names)
                        }
                        
                        appendNamesToWeakList(damageRelations.noDamageTo.map(\.name))
                        appendNamesToWeakList(damageRelations.doubleDamageFrom.map(\.name))
                        
                        appendNamesToStrongList(damageRelations.doubleDamageTo.map(\.name))
                        appendNamesToStrongList(damageRelations.noDamageFrom.map(\.name))
                        
                        self?.createImagesList()
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error)
        }
    }
    
    private func createImagesList() {
        strongAgainstList.forEach {
            let image = UIImage(named: $0) ?? UIImage()
            strongTypesList.append(image)
        }
        
        weakAgainstList.forEach {
            let image = UIImage(named: $0)  ?? UIImage()
            weakTypesList.append(image)
        }
    }
}
