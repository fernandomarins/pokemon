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
        case type(id: String)
        
        var stringValue: String {
            switch self {
            case .list:
                return EndPoints.base + "/pokemon?limit=500"
            case let .pokemon(name):
                return EndPoints.base + "/pokemon/\(name)"
            case let .type(id):
                return EndPoints.base + "/type/\(id)/"
            }
        }
        
        var url: URL? {
            return URL(string: stringValue)
        }
    }
}

extension Service: APIServiceProtocol {
    
    func fetchList(completion: @escaping (Result<PokemonResult, ServiceError>) -> Void) async throws {
        guard let url = EndPoints.list.url else {
            throw ServiceError.badURL
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            let result = try decoder.decode(PokemonResult.self, from: data)
            completion(.success(result))
        } catch {
            throw ServiceError.decodeError
        }
    }
    
    func fetchItem(name: String, completion: @escaping (Result<Pokemon, ServiceError>) -> Void) async throws {
        guard let url = EndPoints.pokemon(name: name).url else {
            throw ServiceError.badURL
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            let result = try! decoder.decode(Pokemon.self, from: data)
            completion(.success(result))
        } catch {
            throw ServiceError.decodeError
        }
    }
    
    func fetchType(id: String, completion: @escaping (Result<PokemonType, ServiceError>) -> Void) async throws {
        guard let url = EndPoints.type(id: id).url else {
            throw ServiceError.badURL
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            let result = try decoder.decode(PokemonType.self, from: data)
            completion(.success(result))
        } catch {
            throw ServiceError.decodeError
        }
    }
}

enum ServiceError: Error {
    case badURL
    case decodeError
}
