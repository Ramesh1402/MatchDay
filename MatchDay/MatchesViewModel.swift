//
//  MatchesViewModel.swift
//  MatchDay
//
//  Created by Ramesh Shanmugam on 21/02/25.
//

import Foundation
import Observation

@Observable class MatchesViewModel {
    var loadingState: LoadinState = .loading
    
    let cricketAPIService = CricketAPIService()
    
    func loadMatches() async {
        loadingState = .loading
        do {
            let matches = try await cricketAPIService.fetchCurrentMatches()
            loadingState = .success(matches)
        } catch {
            loadingState = .failure
        }
    }
}

enum LoadinState {
    case loading
    case success([Match])
    case failure
}
