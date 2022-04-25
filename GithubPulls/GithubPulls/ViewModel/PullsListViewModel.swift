//
//  PullsListViewModel.swift
//  GithubPulls
//
//  Created by Suruchi Sinha on 25/04/22.
//

import Foundation

protocol PullListViewModel {
    var resultsFetched: (() -> ())? { get set }
    var pullDetails: [PullDetails]? { get }
    func fetchClosedPullsList()
    func getCellViewModel(for index: Int) -> PullsCellViewModel
}

class PullListViewModelImpl: PullListViewModel {
    
    var resultsFetched: (() -> ())?
    
    private(set) var pullDetails: [PullDetails]?
    private let apiManager: APIService
    
    init(apiManager: APIService = APIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchClosedPullsList() {
        apiManager.fetchClosedPullRequestsList{ [weak self] result in
            switch result {
            case .success(let response):
                self?.pullDetails = response
                self?.resultsFetched?()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func getCellViewModel(for index: Int) -> PullsCellViewModel {
        guard let pullRequest = pullDetails?[index] else {
            fatalError("Response empty")
        }
        return PullsCellViewModelImpl(title: pullRequest.title,
                                      userName: pullRequest.user.login,
                                      createdAt: pullRequest.createdAt,
                                      closedAt: pullRequest.closedAt,
                                      imageUrl: pullRequest.user.avatarUrl,
                                      apiFetcher: apiManager)
    }
}
