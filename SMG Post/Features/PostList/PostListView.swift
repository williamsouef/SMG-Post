//
//  PostListView.swift
//  SMG Post
//
//  Created by William Souef on 05/06/2025.
//

import Foundation
import SwiftUI

struct PostListView: View {
    @State private var store = PostListStore()   // plus de @StateObject

    var body: some View {
        NavigationStack {
            Group {
                if store.isLoading {
                    ProgressView("Loading")
                } else {
                    List(store.posts) { post in
                        NavigationLink(post.title.capitalized) {
                            PostDetailView(post: post)
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .toolbar {
                NavigationLink { CreatePostView() } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .task { await store.load() }
    }
}

#Preview {
    PostListView()
}
