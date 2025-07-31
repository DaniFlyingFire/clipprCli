import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class Connection 
{
    static func fetchData(from url: URL, token: String) async throws -> String {
        
        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(token, forHTTPHeaderField: "X-API-Key")
        
        // Perform the request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Check HTTP status
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let x = try decoder.decode([Clip].self, from: data)

        let d = Data(base64Encoded: x[0].base64Data)!

        return String(data: d, encoding: .utf8)!
    }

    static func uploadData(to url: URL, token: String, text: String) async throws {

        let data = try JSONEncoder().encode(text)

        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") //
        request.addValue(token, forHTTPHeaderField: "X-API-Key")
        request.httpBody = data

        // Send request
        let (_, response) = try await URLSession.shared.data(for: request)

        // Validate response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}