//
//  Created by Kamolbek on 08/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//
import Foundation

final class PhotoService: NetworkService, PhotoServiceProtocol {
    
    func fetchPhotos(page: Int, success: @escaping ([Image]?) -> Void,
                     failure: @escaping (Error) -> Void) {
        let endpoint: PhotoEndpoint = .new(page: page)
        request(endpoint: endpoint, success: { (response: [Image]) in
            success(response)
        }, failure: { (error) in
            failure(error)
        })
    }
    
    func fetchCollections(success: @escaping ([FeedCategory]?) -> Void,
                          failure: @escaping (Error) -> Void) {
        let endpoint: PhotoEndpoint = .collections
        request(endpoint: endpoint, success: { (response: [FeedCategory]) in
            success(response)
        }, failure: { (error) in
            failure(error)
        })
    }
    
    func fetchCategoryPhoto(page: Int?, title: String?, categoryID:Int? ,success: @escaping (CategoryImages?) -> Void, failure: @escaping (Error) -> Void) {
        let endpoint: PhotoEndpoint = .categoryCollection(title: title, categoryID: categoryID, page: page)
        request(endpoint: endpoint, success: { (response: CategoryImages) in
            success(response)
        }, failure: { (error) in
            failure(error)
        })
    }
    }
