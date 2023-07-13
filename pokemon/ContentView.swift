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
                HStack {
                    VStack {
                        ForEach(viewModel.pokemons, id: \.name) { pokemon in
                            Text(pokemon.name.capitalized)
                                .frame(height: 100)
                        }
                    }

                    Spacer()
                    
                    VStack {
                        ForEach(viewModel.pokemonImageURLs, id: \.self) { image in
                            AsyncImage(url: image) { image in
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
