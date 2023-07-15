//
//  StatsView.swift
//  pokemon
//
//  Created by Fernando Marins on 7/15/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct StatsView: View {
    @StateObject var viewModel = StatsViewModel()
    @State private var imageURL: URL?
    @State private var shiny: Bool = true
    
    var body: some View {
        VStack {
            WebImage(url: imageURL, options: [], context: [.imageThumbnailPixelSize: CGSize.zero])
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
            VStack {
                List(viewModel.statsDict?.keys.sorted() ?? [], id: \.self) { key in
                    HStack {
                        Text(key.capitalized)
                            .bold()
                        Spacer()
                        Text("\(viewModel.statsDict?[key] ?? 0)")
                    }
                }
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(viewModel.name ?? "")
                        .font(.title)
                        .bold()
                }
            }
        }
        .onAppear {
            imageURL = viewModel.fullImage
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
