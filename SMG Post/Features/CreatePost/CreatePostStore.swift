//
//  CreatePostStore.swift
//  SMG Post
//
//  Created by William Souef on 05/06/2025.
//

import Foundation
import SwiftUI

@Observable
@MainActor
final class CreatePostStore {
    var title = ""
    var body  = ""
    var isSubmitting = false
    var createdPost: Post?

    private let service = PostService()

    var isValid: Bool { !title.isEmpty && !body.isEmpty }

    func submit() async {
        guard isValid else { return }
        isSubmitting = true
        defer { isSubmitting = false }
        do {
            let dto = NewPost(title: title, body: body)
            createdPost = try await service.createPost(dto)
        } catch { print(error.localizedDescription) }
    }
}
