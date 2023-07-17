//
//  ContentView.swift
//  pokemon
//
//  Created by Fernando Marins on 7/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject var viewModel = PokemonListViewModel()
    @State private var searchText = String()
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                List {
                    ForEach(searchResults, id: \.self) { pokemon in
                        HStack {
                            WebImage(
                                url: pokemon.image,
                                options: [],
                                context: [.imageThumbnailPixelSize: CGSize.zero]
                            )
                            .placeholder {
                                ProgressView()
                            }
                            .resizable()
                            .frame(width: 100, height: 100)
                            Spacer()
                            VStack(alignment: .center) {
                                Text(pokemon.name.uppercased())
                                    .bold()
                                    .font(.body)
                                Text(pokemon.type)
                                    
                            }
                            Spacer()
                            NavigationLink {
                                DetailView(pokemon: pokemon)
                            } label: {}
                                .fixedSize()
                                .navigationTitle("List")
                        }
                    }
                    .listRowBackground(
                        Capsule(style: .continuous)
                            .fill(Color.white)
                            .padding(2)
                            .frame(width: proxy.size.width * 0.9, height: 110)
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
        .searchable(text: $searchText, prompt: "Type the Pokémon name or type")
    }
    
    var searchResults: [PokemonCellModel] {
        if searchText.isEmpty {
            return viewModel.pokemonCellList
        } else {
            return viewModel.pokemonCellList.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.type.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
