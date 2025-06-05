//
//  PostListStore.swift
//  SMG Post
//
//  Created by William Souef on 05/06/2025.
//

import Foundation
import SwiftUI

@Observable
@MainActor
final class PostListStore {
    var posts: [Post] = []
    var isLoading = false

    private let service = PostService()

    func load() async {
        guard posts.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }

        do   {
            posts = try await service.fetchPosts()
        }
        catch {
            print(error.localizedDescription)
        }

    }
}
