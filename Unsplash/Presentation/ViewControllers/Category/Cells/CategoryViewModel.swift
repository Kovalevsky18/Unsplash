//
//  CategoryViewModel.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/13/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

final class CategoryViewModel {
    
    let cellModels:[FeedNewCellModel]?
    var isLoading: Bool
    let navigationTitle:String?
    let navigationSubtitle:String?
    
    init(images: [Image], isLoading: Bool , categories:FeedCategory) {
        self.isLoading = isLoading
        self.navigationTitle = categories.title ?? ""
        self.navigationSubtitle = String(categories.id ?? 0)
        
        cellModels = images.compactMap({ (image) -> FeedNewCellModel? in
            
            let userName = image.user?.username ?? ""
            let date = image.createdAt ?? ""
            let imageURL = URL(string: image.urls?.regular ?? "" )
            let width = CGFloat(image.width ?? 0)
            let height = CGFloat(image.height ?? 0)
            let likes = image.likes ?? 0
            
            return FeedNewCellModel(userName: userName,
                                    date: date,
                                    imageURL: imageURL,
                                    width: width,
                                    height: height,
                                    likes: likes)
        })
    }
}

// MARK: -  Equatable

extension CategoryViewModel: Equatable {
    static func == (lhs: CategoryViewModel, rhs: CategoryViewModel) -> Bool {
        return lhs.cellModels == rhs.cellModels
    }
}
