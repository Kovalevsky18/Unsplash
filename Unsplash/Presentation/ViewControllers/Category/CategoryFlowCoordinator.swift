//
//  CategoryFlowCoordinator.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/13/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

final class CategoryFlowCoordinator {
    
    private lazy var photoService: PhotoServiceProtocol = PhotoService()
    private weak var view: CategoryViewControllerInput?
    let rootViewController: NavigationController
    let category: FeedCategory
    var isLoading: Bool = false
    var page:Int = 1
    
    private lazy var images: [Image] = []
    
    init(rootViewController: NavigationController , category: FeedCategory) {
        self.rootViewController = rootViewController
        self.category = category
    }
    
    func start(animated: Bool) {
        let viewModel = CategoryViewModel(images: images, isLoading: isLoading, categories: category)
        let viewController = CategoryViewController(viewModel: viewModel)
        viewController.output = self
        view = viewController
        rootViewController.pushViewController(viewController, animated: animated)
    }
    
    private func update(animated: Bool) {
        let viewModel = CategoryViewModel(images: images, isLoading: isLoading, categories: category)
        view?.update(viewModel: viewModel, animated: animated)
    }
    
    func fetchData() {
        isLoading = true // тоже самое для первого vc
        update(animated: true)
        photoService.fetchCategoryPhoto(page: 1, title: category.title, categoryID: category.id, success: { [weak self] (response) in 
            if let response = response, let self = self {
                self.images = response.results
                
                self.isLoading = false
                DispatchQueue.main.async {
                    self.update(animated: true)
                }}})
        { (error) in
            print(error)
        }
    }
}

extension CategoryFlowCoordinator: CategoryViewControllerOutput {
    
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
    
    
    func viewDidLoad() {
        fetchData()
    }
}
