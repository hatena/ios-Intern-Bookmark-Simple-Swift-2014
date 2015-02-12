//
//  BookManager.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/03.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

class BookmarkManager: NSObject {

    var bookmarks: [Bookmark] = []

    class func sharedManager() -> BookmarkManager {

        struct Static {
                static let instance = BookmarkManager()
        }
        return Static.instance
    }

    func reloadBookmarksWithCompletion(completionHandler: (NSError? -> ())?) {
        InternBookmarkAPIClient.sharedClient().getBookmarksWithCompletion() { [weak self] results, error in
            if let jsonResults = results as? [String: AnyObject] {
                if let bookmarksJSON = jsonResults["bookmarks"] as? [AnyObject] {
                    if let weakSelf = self {
                        weakSelf.bookmarks = weakSelf.parseBookmarks(bookmarksJSON)
                    }
                }
            }
            completionHandler?(error)
        }
    }

    func parseBookmarks(bookmarksJSON: [AnyObject]) -> [Bookmark] {
        var bookmarks: [Bookmark] = []

        for bookmarkJSON in bookmarksJSON {
            if let bookmark = bookmarkJSON as? [String: AnyObject] {
                bookmarks.append(Bookmark(JSONDictionary: bookmark))
            }
        }

        return bookmarks
    }
}
