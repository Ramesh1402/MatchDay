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
        Group {
            switch viewModel.loadingState {
            case .loading:
                ProgressView()
            case .success:
                List {
                    ForEach(viewModel.matches, id: \.self) { match in
                        Text(match)
                    }
                }
            case .failure:
                Text("Error loading matches")
            }
        }
        .task {
            await viewModel.loadMatches()
        }
    }
}

#Preview {
    MatchesView()
}
