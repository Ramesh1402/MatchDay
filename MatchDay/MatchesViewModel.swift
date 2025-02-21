//
//  MatchesViewModel.swift
//  MatchDay
//
//  Created by Ramesh Shanmugam on 21/02/25.
//

import Foundation
import Observation

@Observable class MatchesViewModel {
    var matches: [String] = []
    var loadingState: LoadinState = .loading
    
    func loadMatches() async {
        loadingState = .loading
        do {
            try await Task.sleep(for: .seconds(5))
            matches = ["Ind Vs Eng", "SA vs AUS", "ENG vs NZ", "IND vs SA", "AUS vs NZ"]
            loadingState = .success
        } catch {
            loadingState = .failure
        }
       
    }
}

enum LoadinState {
    case loading
    case success
    case failure
}
