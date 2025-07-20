import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class Connection 
{
    static func fetchData(from urlString: String, token: String) async throws -> String {
        // Validate URL
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
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
}