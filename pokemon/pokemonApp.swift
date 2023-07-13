//
//  pokemonApp.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import SwiftUI
import SDWebImageSVGCoder

@main
struct pokemonApp: App {
    
    init() {
        setUpDependencies() // Initialize SVGCoder
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

private extension pokemonApp {
    func setUpDependencies() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
}
