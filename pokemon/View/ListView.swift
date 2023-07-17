//
//  ListView.swift
//  pokemon
//
//  Created by Fernando Marins on 7/15/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListView: View {
    @StateObject var viewModel = ListViewModel()
    @State private var imageURL: URL?
    @State private var shiny: Bool = true
    
    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.isMoveEmpty ? "ABILITIES" : "MOVES")
                .font(.title2)
            Spacer()
            WebImage(
                url: imageURL,
                options: [],
                context: [.imageThumbnailPixelSize: CGSize.zero]
            )
            .placeholder {
                ProgressView()
            }
            .resizable()
            .frame(width: 100, height: 100)
            .onTapGesture {
                imageURL = shiny ? viewModel.fullImageShiny : viewModel.fullImage
                shiny.toggle()
            }
            Spacer()
            List {
                ForEach(viewModel.isMoveEmpty ? abilities : moves, id: \.self) { item in
                    Text(item.capitalized)
                }
                .background(.white)
            }
        }
        .background(.white)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(viewModel.name?.uppercased() ?? "")
                        .font(.title)
                        .bold()
                }
            }
        }
        .onAppear {
            imageURL = viewModel.fullImage
        }
    }
    
    var moves: [String] {
        return viewModel.moves ?? []
    }
    
    var abilities: [String] {
        return viewModel.abilites ?? []
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
