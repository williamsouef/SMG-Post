//
//  Post.swift
//  SMG Post
//
//  Created by William Souef on 05/06/2025.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
