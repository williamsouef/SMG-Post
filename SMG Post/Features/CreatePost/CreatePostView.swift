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

            if store.isSubmitting {
                Section {
                    HStack {
                        ProgressView()
                        Text("Creating post...")
                    }
                }
            }

            if let errorMessage = store.errorMessage {
                Section("Error") {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }

            if let p = store.createdPost {
                Section("✅ Created !") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Post \(p.id) : \(p.title)")
                            .foregroundColor(.green)

                        NavigationLink("View Post Details") {
                            PostDetailView(post: p)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }

            Button("Send") {
                Task { await store.submit() }
            }
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
