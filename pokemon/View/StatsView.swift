//
//  StatsView.swift
//  pokemon
//
//  Created by Fernando Marins on 7/15/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Charts

struct StatsView: View {
    @StateObject var viewModel = StatsViewModel()
    @State private var imageURL: URL?
    @State private var shiny: Bool = true
    
    var body: some View {
        VStack {
            Text("STATS")
                .font(.title2)
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
            Chart {
                ForEach(viewModel.statsDict?
                    .keys
                    .sorted(by: { viewModel.statsDict?[$0] ?? 0 > viewModel.statsDict?[$1] ?? 0 }) ?? [], id: \.self) { key in
                        BarMark(
                            x: .value("", key.capitalized),
                            y: .value("", viewModel.statsDict?[key] ?? 0)
                        )
                        .foregroundStyle(by: .value("", key))
                        .annotation(position: .top) {
                            Text("\(viewModel.statsDict?[key] ?? 0)")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .foregroundColor(.gray)
                        }
                    }
                    
            }
            .chartXAxis(.hidden)
            .padding()
            Spacer()
        }
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
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
