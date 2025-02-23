//
//  MatchDayApp.swift
//  MatchDay
//
//  Created by Ramesh Shanmugam on 21/02/25.
//

import SwiftUI

@main
struct MatchDayApp: App {
    var body: some Scene {
        WindowGroup {
            if isProduction {
                MatchesView()
            }
        }
    }
    
    private var isProduction: Bool {
        NSClassFromString("XCTestCase") == nil
    }
}
