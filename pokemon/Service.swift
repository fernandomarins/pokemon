//
//  Service.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import Foundation

class Service {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    enum EndPoints {
        static let base = "https://pokeapi.co/api/v2"
        
        case list
        case pokemon(name: String)
        
        var stringValue: String {
            switch self {
            case .list:
                return EndPoints.base + "/pokemon?limit=151"
            case let .pokemon(name):
                return EndPoints.base + "/pokemon/\(name)"
            }
        }
        
        var url: URL? {
            return URL(string: stringValue)
        }
    }
}

extension Service: APIServiceProtocol {
    
    func fetchList(completion: @escaping (Result<PokemonList, ServiceError>) -> Void) async {
        guard let url = EndPoints.list.url else {
            completion(.failure(.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            let result = try decoder.decode(PokemonList.self, from: data)
            completion(.success(result))
            // Use the decoded result here
        } catch {
            completion(.failure(.decodeError))
        }
    }
    
    func fetchItem(completion: @escaping (Result<Pokemon, ServiceError>) -> Void) async {
        guard let url = URL(string: "https://pokeapi.co/api/v2") else {
            completion(.failure(.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            let result = try decoder.decode(Pokemon.self, from: data)
            completion(.success(result))
            // Use the decoded result here
        } catch {
            completion(.failure(.decodeError))
        }
    }
}

enum ServiceError: Error {
    case badURL
    case decodeError
}
