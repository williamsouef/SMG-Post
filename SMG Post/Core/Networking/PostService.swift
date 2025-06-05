//
//  PostService.swift
//  SMG Post
//
//  Created by William Souef on 05/06/2025.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

final class PostService {
    private let baseURL = "https://jsonplaceholder.typicode.com"
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) { self.session = session }

    func fetchPosts() async throws -> [Post] {
        try await request(endpoint: "/posts")
    }

    func fetchComments(for postId: Int) async throws -> [Comment] {
        try await request(endpoint: "/posts/\(postId)/comments")
    }

    func createPost(_ post: NewPost) async throws -> Post {
        try await request(endpoint: "/posts", method: "POST", body: post)
    }

    // MARK: - Generic request helpers
    private func request<T: Decodable>(
        endpoint: String,
        method: String = "GET"
    ) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else { throw APIError.unknown }
        var req = URLRequest(url: url)
        req.httpMethod = method

        let (data, resp) = try await session.data(for: req)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.wrongStatusCode }
        do { return try JSONDecoder().decode(T.self, from: data) }
        catch { throw APIError.decoding }
    }

    private func request<T: Decodable, B: Encodable>(
        endpoint: String,
        method: String = "GET",
        body: B
    ) async throws -> T {
        
        guard let url = URL(string: baseURL + endpoint) else { throw APIError.unknown }
        var req = URLRequest(url: url)
        req.httpMethod = method
        req.httpBody = try JSONEncoder().encode(body)
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, resp) = try await session.data(for: req)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.wrongStatusCode
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }
        catch {
            throw APIError.decoding
        }
    }
}
