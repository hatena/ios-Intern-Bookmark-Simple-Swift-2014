//
//  InternBookmarkAPIClient.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/03.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

protocol InternBookmarkAPIClientProtocol {
    func APIClientNeedsLogin(client : InternBookmarkAPIClient)
}

struct APIClientConstants {
    static let internBookmarAPIBaseURLString: String = "http://localhost:3000/"
}

class InternBookmarkAPIClient: AFHTTPSessionManager {

    var delegate: InternBookmarkAPIClientProtocol?

    class func sharedClient() -> InternBookmarkAPIClient {
        struct Static {
            static let instance: InternBookmarkAPIClient = {
                let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
                configuration.HTTPAdditionalHeaders = [
                    "Accept" : "application/json",
                ]
                let internBookmarkAPIClient = InternBookmarkAPIClient(baseURL:
                    NSURL.URLWithString(APIClientConstants.internBookmarAPIBaseURLString), sessionConfiguration: configuration)

                return internBookmarkAPIClient
            }()
        }
        return Static.instance
    }

    class func loginURL() -> NSURL {
        return NSURL.URLWithString(APIClientConstants.internBookmarAPIBaseURLString).URLByAppendingPathComponent("login")
    }

    func getBookmarksWithCompletion(block: ((AnyObject!,  NSError!) -> Void)!) {

        self.GET("/api/bookmarks",
            parameters: [],
            success: { (task: NSURLSessionDataTask!, responseObject: AnyObject!) in
                if (block) {
                    block(responseObject, nil)
                }
            }, failure: { (task: NSURLSessionDataTask!, error: NSError!) in
                if ((task.response as? NSHTTPURLResponse)?.statusCode == 401 && self.needsLogin()) {
                    if (block) {
                        block(nil, nil)
                    }
                }
                else {
                    if (block) {
                        block(nil, error)
                    }
                }
            })
    }

    func needsLogin() -> Bool {
        return (self.delegate?.APIClientNeedsLogin(self) != nil)
    }
}
