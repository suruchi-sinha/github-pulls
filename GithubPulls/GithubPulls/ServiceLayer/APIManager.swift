import Foundation
import UIKit

struct PullDetails: Decodable {
    let title: String
    let closedAt: String
    let createdAt: String
    let user: User
}

struct User: Decodable {
    let login: String
    let avatarUrl: String
}

protocol APIService {
    func fetchClosedPullRequestsList(completion: @escaping (Result<[PullDetails], Error>)->())
    func fetchImage(urlString: String, completion: @escaping (UIImage?) -> ())
}

final class APIManager: APIService {
    
    func fetchClosedPullRequestsList(completion: @escaping (Result<[PullDetails], Error>) -> ()) {
        
        guard var urlComponents = URLComponents(string: URLConstants.baseURL) else {
            return
        }
        let queryItems = [URLQueryItem(name: "state", value: "closed")]
        urlComponents.queryItems = queryItems
        
        let dataTask = URLSession.shared.dataTask(with: urlComponents.url!) { data, _ , error in
            guard let data = data else {
                // return error
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let response = try decoder.decode([PullDetails].self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    func fetchImage(urlString: String, completion: @escaping (UIImage?) -> ()) {
        guard let imageUrl = URL(string: urlString) else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: imageUrl) { data, _, error in
            guard let data = data else {
                // return error
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
        dataTask.resume()
    }
}


private struct URLConstants {
    static let baseURL = "https://api.github.com/repos/suruchi-sinha/github-pulls/pulls"
}
