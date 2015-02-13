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

    let sessionManager: AFHTTPSessionManager
    var delegate: APIClientProtocol?

    class func sharedClient() -> InternBookmarkAPIClient {
        struct Static {
            static let instance = InternBookmarkAPIClient()
        }
        return Static.instance
    }

    class func loginURL() -> NSURL? {
        return NSURL(string: APIClientConstants.APIBaseURLString)?.URLByAppendingPathComponent("login")
    }

    override init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = [
            "Accept" : "application/json",
        ]

        sessionManager = AFHTTPSessionManager(baseURL: NSURL(string: APIClientConstants.APIBaseURLString),
            sessionConfiguration: configuration)
    }

    func getBookmarksWithCompletion(completionHandler: ((AnyObject?,  NSError?) -> ())?) {

        sessionManager.GET("/api/bookmarks",
            parameters: nil,
            success: { (_, responseObject) in
                completionHandler?(responseObject, nil)
                return
            })
            { (task, error) in
                // 401 が返ったときログインが必要.
                if (task.response as? NSHTTPURLResponse)?.statusCode == 401 && self.needsLogin() {
                    completionHandler?(nil, nil);
                }
                else {
                    completionHandler?(nil, error);
                }
        }
    }

    func needsLogin() -> Bool {
        return (delegate?.APIClientNeedsLogin(self) != nil)
    }
}
