import Foundation

final class LinkSheetService {
    static let shared = LinkSheetService()

    private init() {}

    // Replace with your deployed Apps Script web app URL
    private let endpoint = URL(string: "https://script.google.com/macros/s/AKfycbx-jjEIWSuSMGlL3bfkE1se_FZZP8O796CjjrdGNbiv9EtvgUFSk1ebqyFAB-2e0O_n/exec")!

    enum ServiceError: LocalizedError {
        case invalidResponse
        case serverError(String)
        case invalidURL

        var errorDescription: String? {
            switch self {
            case .invalidResponse:
                return "Invalid response from server."
            case .serverError(let msg):
                return msg
            case .invalidURL:
                return "Invalid URL."
            }
        }
    }

    struct ResponsePayload: Decodable {
        let ok: Bool?
        let message: String?
    }

    func sendLink(url: URL, category: String, completion: @escaping (Result<String?, Error>) -> Void) {
        guard !url.absoluteString.isEmpty else {
            completion(.failure(ServiceError.invalidURL))
            return
        }

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload: [String: Any] = [
            "url": url.absoluteString,
            "category": category,
            "ts": ISO8601DateFormatter().string(from: Date())
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let http = response as? HTTPURLResponse else {
                completion(.failure(ServiceError.invalidResponse))
                return
            }

            guard (200..<300).contains(http.statusCode) else {
                let body = data.flatMap { String(data: $0, encoding: .utf8) } ?? "HTTP \(http.statusCode)"
                completion(.failure(ServiceError.serverError(body)))
                return
            }

            // Apps Script often returns plain text; try JSON first, fallback to text.
            if let data = data,
               let decoded = try? JSONDecoder().decode(ResponsePayload.self, from: data) {
                if decoded.ok == false {
                    completion(.failure(ServiceError.serverError(decoded.message ?? "Server error.")))
                } else {
                    completion(.success(decoded.message))
                }
                return
            }

            let text = data.flatMap { String(data: $0, encoding: .utf8) }
            completion(.success(text?.isEmpty == true ? nil : text))
        }.resume()
    }
}
