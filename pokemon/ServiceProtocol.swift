//
//  ServiceProtocol.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import Foundation

protocol URLSessionProtocol {
    func fetchData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    func fetchDataRequest(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

protocol APIServiceProtocol {
    func fetchList(completion: @escaping (Result<PokemonResult, ServiceError>) -> Void) async throws
    func fetchItem(name: String, completion: @escaping (Result<Pokemon, ServiceError>) -> Void) async throws
}

extension URLSession: URLSessionProtocol {
    func fetchData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let dataTask = dataTask(with: url, completionHandler: completionHandler)
        dataTask.resume()
    }
    
    func fetchDataRequest(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let dataTask = dataTask(with: request, completionHandler: completionHandler)
        dataTask.resume()
    }
}
