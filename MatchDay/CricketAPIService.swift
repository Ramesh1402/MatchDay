//
//  CricketAPIService.swift
//  MatchDay
//
//  Created by Ramesh Shanmugam on 21/02/25.
//

import Foundation

struct CricketAPIService {
    func fetchCurrentMatches() async throws -> [Match] {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.cricapi.com"
        urlComponents.path = "/v1/currentMatches"
        urlComponents.queryItems = [URLQueryItem(name: "apikey", value: "8c8ff01a-004a-42b7-9a6f-a554e63487a3"),
                                    URLQueryItem(name: "offset", value: "0")]
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw APIError.invalidResponse
        }
        
        let jsonDecoder = JSONDecoder()
        guard let matchesResponse = try? jsonDecoder.decode(MatchesResponse.self, from: data).self else {
            throw APIError.invalidResponse
        }
                
        return matchesResponse.data
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
}

struct MatchesResponse: Decodable {
    let data: [Match]
}

struct Match: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let matchType: String
    let status: String
    let teams: [Team]
}

enum Team: String, Decodable, CaseIterable {
    case oman
    case usa
    case unknown
    
    var flagURL: URL? {
        var countryName: String
        
        switch self {
        case .oman:
            countryName = "oman"
        case .usa:
            countryName = "usa"
        case .unknown:
            return nil
        }
        
        return URL(string: "https://www.countryflags.com/wp-content/uploads/\(countryName)-flag-png-large.png")
    }
    enum CodingKeys: String, CodingKey {
        case oman = "Oman"
        case usa = "United States of America"
        case unknowm
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let decodedValue = try container.decode(String.self)
        
        if let result = Team.allCases.first(where: { $0.rawValue.lowercased() == decodedValue.lowercased() }) {
            self = result
        } else {
            self = .unknown
        }
    }
}
