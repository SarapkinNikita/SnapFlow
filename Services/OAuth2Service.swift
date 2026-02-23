import UIKit

protocol OAuth2ServiceProtocol {
    func fetchAuthToken(code: String,
                         completion: @escaping (Result<String, Error>) -> Void)
}

// MARK: - OAuth2Service
final class OAuth2Service: OAuth2ServiceProtocol {
    
    // MARK: - Singleton
    static let shared = OAuth2Service()
    private init() {}
    
    // MARK: - Private Methods
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token") else {
            print("OAuth: Failed to create URLComponents")
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        
        guard let url = urlComponents.url else {
            print("OAuth: Failed to create URL from URLComponents")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    // MARK: - Public Methods
    func fetchAuthToken(code: String,
                         completion: @escaping (Result<String, Error>) -> Void) {
        guard let request = makeOAuthTokenRequest(code: code) else {
            print("Failed to create OAuth token request")
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        let task = URLSession.shared.data(for: request) { result in
            // status code check URLSession+data
            switch result {
            case .success(let data):
                do {
                    let token = try JSONDecoder().decode(OAuthTokenResponseBody.self, from: data)
                    let storage = OAuth2TokenStorage()
                    storage.token = token.accessToken
                    completion(.success(token.accessToken))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(NetworkError.decodingError(error)))
                }
            case .failure(let error):
                print("OAuth token request failed: \(error)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

