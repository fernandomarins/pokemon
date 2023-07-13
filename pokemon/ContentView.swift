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
        NavigationStack {
            GeometryReader { proxy in
                List {
                    ForEach(viewModel.pokemonCellList, id: \.self) { pokemon in
                        HStack {
                            AsyncImage(url: pokemon.image) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                            } placeholder: {
                                ProgressView()
                            }
                            Spacer()
                            VStack(alignment: .center) {
                                Text(pokemon.name.uppercased())
                                    .bold()
                                    .font(.body)
                                Spacer()
                                Text(pokemon.type)
                                    
                            }
                            Spacer()
                        }
                    }
                    .listRowBackground(
                        Capsule(style: .continuous)
                            .fill(Color.white)
                            .padding(2)
                            .frame(width: proxy.size.width * 0.9, height: 100)
                    )
                    .listRowSeparator(.hidden)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Pokémon List").font(.title)
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
