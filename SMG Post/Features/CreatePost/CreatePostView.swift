//
//  CreatePostView.swift
//  SMG Post
//
//  Created by William Souef on 05/06/2025.
//

import Foundation
import SwiftUI

struct CreatePostView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var store = CreatePostStore()

    var body: some View {
        Form {
            Section("Title") {
                TextField("My Amazing Title", text: $store.title)
            }
            Section("Content") {
                TextField("Describe it...", text: $store.body, axis: .vertical)
                    .lineLimit(3...6)
            }
            if let p = store.createdPost {
                Section("✅ Created !") {
                    Text("Post \(p.id) : \(p.title)")
                }
            }
            Button("Send") { Task { await store.submit() } }
                .disabled(!store.isValid || store.isSubmitting)
        }
        .navigationTitle("Create my post")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Close") { dismiss() }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreatePostView()
    }
}
