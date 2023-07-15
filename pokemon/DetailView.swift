//
//  DetailView.swift
//  pokemon
//
//  Created by Fernando Marins on 7/13/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @StateObject var viewModel = DetailViewViewModel()
    @State private var imageURL: URL?
    @State private var shiny: Bool = true
    
    let pokemon: PokemonCellModel?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 10) {
                WebImage(url: imageURL, options: [], context: [.imageThumbnailPixelSize: CGSize.zero])
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .frame(width: 250, height: 250)
                    .onTapGesture {
                        imageURL = shiny ? pokemon?.fullImageShiny : pokemon?.fullImage
                        shiny.toggle()
                    }
                HStack {
                    Spacer()
                    HStack {
                        Text("Type: ")
                            .font(.title)
                            .bold()
                        Text(pokemon?.type.capitalized ?? "")
                            .font(.title)
                    }
                    Spacer()
                    HStack {
                        Text("Pokédex: ")
                            .font(.title)
                            .bold()
                        Text(String(pokemon?.index ?? 0))
                            .font(.title)
                    }
                    Spacer()
                }
                VStack(alignment: .center) {
                    if !(viewModel.pokemonDetailModel?.isStrongEmpty ?? false) {
                        HStack(alignment: .center) {
                            Text("Strong against:")
                                .bold()
                            ForEach(viewModel.pokemonDetailModel?.strongList ?? [], id: \.self) {
                                Image("\($0)")
                                    .frame(width: 30, height: 30)
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                    if !(viewModel.pokemonDetailModel?.isWeakEmpty ?? false) {
                        HStack(alignment: .center) {
                            Text("Weak against:")
                                .bold()
                            ForEach(viewModel.pokemonDetailModel?.weakList ?? [], id: \.self) {
                                Image("\($0)")
                                    .frame(width: 30, height: 30)
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                    
                }
                List {
                    ForEach(pokemon?.moves ?? [], id: \.self) { moves in
                        Text(moves.move.name.capitalized)
                    }
                    .background(.white)
                }
                .background(.white)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(pokemon?.name.uppercased() ?? "")
                            .font(.title)
                            .bold()
                    }
                }
            }
            .onAppear {
                Task {
                    imageURL = pokemon?.fullImage
                    await viewModel.fetchPokemonType(id: pokemon?.index)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(pokemon: nil)
    }
}
