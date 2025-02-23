//
//  ContentView.swift
//  MatchDay
//
//  Created by Ramesh Shanmugam on 21/02/25.
//

import SwiftUI

struct MatchesView: View {
    @State var viewModel = MatchesViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.loadingState {
                case .loading:
                    ProgressView()
                case .success(let matches):
                    VStack {
                        List {
                            ForEach(matches) { match in
                                NavigationLink(value: match) {
                                    MatchCardView(match: match)
                                        .listRowInsets(EdgeInsets())
                                        .padding(.bottom, 4)
                                        .background(Color.gray.opacity(0.3))
                                }
                            }
                        }
                    }
                case .failure:
                    Text("Error loading matches")
                }
            }
            .navigationTitle("Current Matches")
            .navigationDestination(for: Match.self, destination: { match in
                MatchCardView(match: match)
                    .listRowInsets(EdgeInsets())
                    .padding(.bottom, 4)
                    .background(Color.gray.opacity(0.3))
            })
            .task {
                await viewModel.loadMatches()
            }
        }
    }
}

struct MatchCardView: View {
    let match: Match
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                AsyncImage(url: match.teams[0].flagURL) { image in
                    image
                        .resizable()
                        .frame(width: 120, height: 70)
                    
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 120, height: 70)
                }
                Spacer()
                Text(match.matchType)
                Spacer()
                AsyncImage(url: match.teams[1].flagURL) { image in
                    image
                        .resizable()
                        .frame(width: 120, height: 70)
                    
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 120, height: 70)
                }
            }
            Text(match.status)
        }
    }
}

//#Preview {
//    MatchCardView(match: Match(id: "1",
//                               name: "Dummy Match",
//                               teams: [.oman, .usa]))
//}
