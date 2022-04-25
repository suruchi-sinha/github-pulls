//
//  PullsCellViewModel.swift
//  GithubPulls
//
//  Created by Suruchi Sinha on 25/04/22.
//

import Foundation
import UIKit

protocol PullsCellViewModel {
    var title: String { get }
    var userName: String { get }
    var createdAt: String { get }
    var closedAt: String { get }
    var imageUrl: String { get }
    func getImage(completion: @escaping (UIImage?) -> ())
}

class PullsCellViewModelImpl: PullsCellViewModel {
    let title: String
    let userName: String
    let createdAt: String
    let closedAt: String
    let imageUrl: String
    private var cachedImage: UIImage?
    private let apiFetcher: APIService
    
    init(title: String,
         userName: String,
         createdAt: String,
         closedAt: String,
         imageUrl: String,
         apiFetcher: APIService) {
        self.title = title
        self.userName = userName
        self.createdAt = createdAt
        self.closedAt = closedAt
        self.imageUrl = imageUrl
        self.apiFetcher = apiFetcher
    }
    
    func getImage(completion: @escaping (UIImage?) -> ()) {
        if let image = cachedImage {
            completion(image)
            return
        }
        apiFetcher.fetchImage(urlString: imageUrl) { image in
            completion(image)
        }
    }
}
