//
//  OpenAPIClient.swift
//  swift-openapi-generator
//
//  Created by yuki.hamada on 2025/05/20.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

final class OpenAPIClient {
    let client: Client
    init() {
        self.client = .init(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
    }

    func greet() async throws {
        let response = try await client.getGreeting(
            .init(query: .init(name: "hogehoge"))
        )

        switch response {
        case .ok(let value):
            switch value.body {
//            case .json(let json):
            case .json(let greeting):
                let message = greeting.message
            }
        case .undocumented(statusCode: let statusCode, _):
            print(statusCode)
        }
    }

    /// Viewで扱う型（ContentViewState）に変換する
    func greetTranslator(greeting: Components.Schemas.Greeting) -> ContentViewState {
        let newMessage = "Hello \(greeting.message)"
        return .init(message: greeting.message)
    }
}
