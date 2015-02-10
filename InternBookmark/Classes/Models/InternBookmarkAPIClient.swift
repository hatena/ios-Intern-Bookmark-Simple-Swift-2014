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
            static let instance: InternBookmarkAPIClient = InternBookmarkAPIClient()
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

    func createURL(URL : String) -> String {
        return APIClientConstants.APIBaseURLString + URL
    }

    func getBookmarksWithCompletion(block: ((AnyObject?,  NSError?) -> Void)?) {

        sessionManager.GET("/api/bookmarks",
            parameters: nil,
            success: { (_, responseObject: AnyObject!) in
                block?(responseObject, nil)
                return
            })
            { (task: NSURLSessionDataTask!, error: NSError!) in
                // 401 が返ったときログインが必要.
                if ((task.response as? NSHTTPURLResponse)?.statusCode == 401 && self.needsLogin()) {
                    block?(nil, nil);
                }
                else {
                    block?(nil, error);
                }
        }
    }

    func needsLogin() -> Bool {
        return (self.delegate?.APIClientNeedsLogin(self) != nil)
    }
}
