//
//  PostDetailView.swift
//  SMG Post
//
//  Created by William Souef on 05/06/2025.
//

import Foundation
import SwiftUI

struct PostDetailView: View {
    @State private var store: PostDetailStore

    init(post: Post) {
        _store = .init(initialValue: PostDetailStore(post: post))
    }

    var body: some View {
        ScrollView {
            AsyncImage(url: .init(string: "https://picsum.photos/600/300")) { phase in
                switch phase {
                    case .success(let img): img.resizable().scaledToFill()
                    default: Color.gray.opacity(0.3)
                }
            }
            .frame(height: 200).clipped()

            VStack(alignment: .leading, spacing: 16) {
                Text(store.post.title.capitalized)
                    .font(.title2).bold()
                Text(store.post.body)
                Divider()
                Text("Comments").font(.headline)
                ForEach(store.comments) { c in
                    VStack(alignment: .leading) {
                        Text(c.name).bold()
                        Text(c.body)
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .task { await store.load() }
    }
}

#Preview {
    NavigationStack {
        PostDetailView(post: Post(
            id: 1,
            userId: 1,
            title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
        ))
    }
}
