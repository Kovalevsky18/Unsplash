//
//  FeedFlowCoordinator.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/8/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

final class FeedFlowCoordinator {
    
    typealias Success<T> = (T) -> Void
    typealias Failure = (Error) -> Void
    
    let rootViewController: NavigationController
    private lazy var photoService: PhotoServiceProtocol = PhotoService()
    private lazy var images: [Image] = []
    private lazy var collections: [FeedCategory] = []
    private weak var view: FeedViewControllerInput?
    var isLoading: Bool = false
    var categoryCoordinator: CategoryFlowCoordinator?
    var page: Int = 1
    var loginFlowCoordinator: LoginFlowCoordinator?
    
    init(rootViewController: NavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start(animated: Bool) {
        let viewModel = FeedViewModel(categories: collections, images: images, isLoading: isLoading)
        let viewController = FeedViewController(viewModel: viewModel)
        viewController.output = self
        view = viewController
        rootViewController.setViewControllers([viewController], animated: animated)
    }
    
    private func update(animated: Bool) {
        let viewModel = FeedViewModel(categories: collections, images: images, isLoading: isLoading)
        view?.update(viewModel: viewModel, animated: animated)
    }
    
    func fetchData() {
        isLoading = true
        update(animated: true)
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        photoService.fetchPhotos(page: page, success: { [weak self] images in
            if let images = images, let self = self {
                self.images = images
            }
            dispatchGroup.leave()
            }, failure: { error in
                dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        photoService.fetchCollections(success: { [weak self] collections in
            if let collections = collections, let self = self {
                self.collections = collections
            }
            dispatchGroup.leave()
        }) { error in
            print(error)
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
            self.update(animated: false)
        }
    }
}

extension FeedFlowCoordinator: FeedViewControllerOutput {
    
    func loginButtonDidSelect() {
        loginFlowCoordinator = LoginFlowCoordinator(rootViewController: rootViewController)
        loginFlowCoordinator?.start(animated: true)
    }
    
    
    func viewDidLoad() {
        print("vc load")
        fetchData()
    }
    
    func viewDidRequestNewPage() {
      guard !isLoading else {
            return
        }
        
        isLoading = true
        page += 1
        photoService.fetchPhotos(page: page, success: { [weak self] images in
            if let images = images, let self = self {
                self.images.append(contentsOf: images)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.update(animated: true)
                }
            }
            }, failure: {[weak self] error in
                DispatchQueue.main.async {
                    print(error)
                    self?.isLoading = false
                    self?.update(animated: true)
                }
            }
        )
    }
    
    func viewDidSelect(category with: IndexPath) {
        guard let category = collections[safe: with.row] else {
            return
        }

        let categoryFlowCoordinator = CategoryFlowCoordinator(rootViewController: rootViewController, category: category)
        categoryFlowCoordinator.start(animated: true)
        self.categoryCoordinator = categoryFlowCoordinator
    }
}


