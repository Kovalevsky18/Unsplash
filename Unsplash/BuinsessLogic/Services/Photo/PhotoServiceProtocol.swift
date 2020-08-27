//
//  PhotoServiceProtocol.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/9/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

protocol PhotoServiceProtocol: class {
    func fetchPhotos(page: Int, success: @escaping ([Image]?) -> Void,
                     failure: @escaping (Error) -> Void)
    
    func fetchCollections(success: @escaping ([FeedCategory]?) -> Void,
                          failure: @escaping (Error) -> Void)
    
    func fetchCategoryPhoto(page: Int?, title: String?, categoryID: Int?,success: @escaping (CategoryImages?) -> Void,
                            failure: @escaping (Error) -> Void)
}
