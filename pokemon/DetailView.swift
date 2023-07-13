//
//  DetailView.swift
//  pokemon
//
//  Created by Fernando Marins on 7/13/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    let pokemon: PokemonCellModel?
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            WebImage(url: pokemon?.fullImage, options: [], context: [.imageThumbnailPixelSize : CGSize.zero])
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .frame(width: 250, height: 250)
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
            Spacer()
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
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(pokemon: nil)
    }
}
