//
//  PostDetailStore.swift
//  SMG Post
//
//  Created by William Souef on 05/06/2025.
//

import Foundation
import SwiftUI

@Observable
@MainActor
final class PostDetailStore {
    let post: Post
    var comments: [Comment] = []
    var isLoading = false

    private let service = PostService()

    init(post: Post) {
        self.post = post
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }
        do {
            comments = try await service
                .fetchComments(for: post.id)
                .prefix(3)
                .map { $0 }
        } catch {
            print(error.localizedDescription)
        }
    }
}
