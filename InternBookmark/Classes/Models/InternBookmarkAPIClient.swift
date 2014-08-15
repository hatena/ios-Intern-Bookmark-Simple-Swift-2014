//
//  InternBookmarkAPIClient.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/03.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

protocol APIClientProtocol {
    func APIClientNeedsLogin(client : InternBookmarkAPIClient)
}

struct APIClientConstants {
    static let APIBaseURLString: String = "http://localhost:3000"
}

class InternBookmarkAPIClient: NSObject {

    var delegate: APIClientProtocol?

    class func sharedClient() -> InternBookmarkAPIClient {
        struct Static {
            static let instance: InternBookmarkAPIClient = InternBookmarkAPIClient()
        }
        return Static.instance
    }

    class func loginURL() -> NSURL {
        return NSURL.URLWithString(APIClientConstants.APIBaseURLString).URLByAppendingPathComponent("login")
    }

    func createURL(URL : String) -> String {
        return APIClientConstants.APIBaseURLString + URL
    }

    func getBookmarksWithCompletion(block: ((AnyObject!,  NSError!) -> Void)!) {

        Alamofire.request(.GET, self.createURL("/api/bookmarks"))
            .responseJSON {(request, response, JSON, error) in
                if (error != nil) {
                    if (response?.statusCode == 401 && self.needsLogin()) {
                        if (block) {
                            block(nil, nil)
                        }
                    } else {
                        if (block) {
                            block(nil, error)
                        }
                    }
                } else {
                    if (block) {
                        block(JSON, nil)
                    }
                }
        }
    }

    func needsLogin() -> Bool {
        return (self.delegate?.APIClientNeedsLogin(self) != nil)
    }
}
