//
//  APIError.swift
//  SMG Post
//
//  Created by William Souef on 05/06/2025.
//

import Foundation

enum APIError: Error, LocalizedError {

    case wrongStatusCode
    case decoding
    case unknown

    var errorDescription: String? {
        switch self {
            case .wrongStatusCode: 
                return "Invalid server response"
            case .decoding:
                return "Impossible decoding of the data received from the server"
            case .unknown:
                return "unknown error occurred"
        }
    }
}
