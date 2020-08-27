//  Created by Komolbek Ibragimov on 08/07/2020
//  Copyright © 2020 HiQo. All rights reserved.

import Foundation

enum PhotoEndpoint {
    case new(page: Int), explore , collections
    case categoryCollection(title: String?, categoryID: Int?, page: Int? )
}

enum PathEndpoint {
    case photos , collections
}

extension PhotoEndpoint: Endpoint {
    
    var baseURL: URL {
        AppConfiguration.serverURL
    }
    
    var path: String {
        switch self {
        case .explore :
            return "photos"
        case .collections:
            return "collections"
        case .categoryCollection( _, _, _):
            return "search/photos"
        case .new( _):
            return "photos"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .explore:
            return ["client_id": AppConfiguration.apiKey,
                    "query": "explore"]
        case .collections:
            return ["client_id": AppConfiguration.apiKey]
            
        case .categoryCollection(let title, let categoryID, let page):
            return ["client_id": AppConfiguration.apiKey,
                    "query": title ?? "",
                    "collections": categoryID ?? "",
                    "page": "\(page ?? 1)",
                    "per_page": "30"]
        case .new(let page):
            return ["client_id": AppConfiguration.apiKey,
                    "query": "new",
                    "page": "\(page )",
                    "per_page": "30"]
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : Any] {
        [:]
    }
    
    var parameterEncoding: ParameterEncoding {
        return .URLEncoding
    }
}
