//
//  Extensions.swift
//  pokemon
//
//  Created by Fernando Marins on 7/14/23.
//

import Foundation

extension ObservableObject {
    func convertObjectToData<T: Encodable>(object: T) -> Data? {
        do {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(object)
            return data
        }
    }
    
    func convertObjectFromData<T: Decodable>(data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            let array = try? decoder.decode(T.self, from: data)
            return array
        }
    }
}
