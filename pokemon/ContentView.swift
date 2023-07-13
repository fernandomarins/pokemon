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
                ForEach(viewModel.pokemonCellList, id: \.self) { pokemon in
                    HStack {
                        Text(pokemon.name.capitalized)
                        Spacer()
                        Text(pokemon.type.capitalized)
                        Spacer()
                        AsyncImage(url: pokemon.image) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchPokemonList()
                await viewModel.fetchPokemonURL()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
