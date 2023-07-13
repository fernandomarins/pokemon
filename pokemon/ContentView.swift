//
//  ContentView.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.pokemons, id: \.name) {
                    Text($0.name)
                }
            }
        }
        .onAppear {
            Task {
                do {
                    await viewModel.fetchPokemonList()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
