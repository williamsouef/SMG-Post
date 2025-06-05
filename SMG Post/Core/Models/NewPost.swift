//
//  NewPost.swift
//  SMG Post
//
//  Created by William Souef on 05/06/2025.
//

import Foundation

struct NewPost: Codable {
    var userId: Int = 1
    let title: String
    let body: String
}
