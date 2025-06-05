//
//  Comment.swift
//  SMG Post
//
//  Created by William Souef on 05/06/2025.
//

import Foundation

struct Comment: Codable, Identifiable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
}
