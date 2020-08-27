//
//  Created by Kamolbek on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

enum SectionTitle: String, CaseIterable {
    case explore, new
    
    var title: String? {
        switch self {
        case .explore:
            return "explore"
        case .new:
            return "new"
        }
    }
}

final class FeedViewModel {
    
    let feedSectionModels: [FeedSectionModel]
    var isLoading:Bool
    
    
    init(categories: [FeedCategory], images: [Image], isLoading: Bool) {
        
        self.isLoading = isLoading
        feedSectionModels = SectionTitle.allCases.compactMap({ (type) -> FeedSectionModel? in
            var cellModels: [FeedCellModel]?
            switch type {
            case .explore:
                cellModels = categories.compactMap({ (category) -> FeedExploreCellModel? in
                    let imageURL = URL(string: category.tags.first??.source?.coverPhoto?.urls?.regular ?? "")
                    let user = category.tags.first??.source?.coverPhoto?.user?.username
                    return FeedExploreCellModel(title: category.title?.uppercased(),
                                                imageURL: imageURL )
                })
            case .new:
                cellModels = images.compactMap({ (image) -> FeedNewCellModel? in
                    
                    let userName = image.user?.username
                    let date = image.createdAt
                    let imageURL = URL(string: image.urls?.regular ?? "")
                    let width = CGFloat(image.width ?? 0)
                    let height = CGFloat(image.height ?? 0)
                    let likes = image.likes 
                    
                    return FeedNewCellModel(userName: userName,
                                            date: date,
                                            imageURL: imageURL,
                                            width: width,
                                            height: height,
                                            likes: likes)
                })
            }
            return FeedSectionModel(title: type.title, cellModels: cellModels)
        })
    }
}

// MARK: -  Equatable

extension FeedViewModel: Equatable {
    static func == (lhs: FeedViewModel, rhs: FeedViewModel) -> Bool {
        return lhs.feedSectionModels == rhs.feedSectionModels // для сравнения viewModels
    }
}
