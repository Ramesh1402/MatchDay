//
//  MatchesViewModelTests.swift
//  MatchDay
//
//  Created by Ramesh Shanmugam on 23/02/25.
//

import XCTest
import Dependencies
@testable import MatchDay

final class MatchesViewModelTests: XCTestCase {
    var subject: MatchesViewModel!
    
    override func setUpWithError() throws {
        subject = MatchesViewModel()
    }

    func test_loadMatches_success() async throws {
        let matches = [Match(id: "1",
                             name: "Name",
                             matchType: "T20",
                             status: "Done",
                             teams: [Team.oman, Team.usa])]
        await withDependencies { d in
            d.cricketAPIService = CricketAPIService(fetchCurrentMatches: {
                return matches
            })
        } operation: {
            await subject.loadMatches()
            XCTAssertEqual(subject.loadingState, .success(matches))
        }
    }
    
    override func tearDownWithError() throws {
    }
}
