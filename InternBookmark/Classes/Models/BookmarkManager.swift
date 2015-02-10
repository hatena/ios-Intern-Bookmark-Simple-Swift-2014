//
//  BookManager.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/03.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

class BookmarkManager: NSObject {

    var bookmarks: Array<Bookmark>!

    class func sharedManager() -> BookmarkManager {

        struct Static {
                static let instance: BookmarkManager = BookmarkManager()
        }
        return Static.instance
    }

    override init() {
        self.bookmarks = []
    }

    func reloadBookmarksWithBlock(block: ((NSError!) -> Void)?) {
        InternBookmarkAPIClient.sharedClient().getBookmarksWithCompletion( { (results: AnyObject?, error: NSError?) in
            if (results != nil) {
                let jsonResults: [String: AnyObject]! = results as? [String: AnyObject]
                let bookmarksJSON: [AnyObject]! = (jsonResults["bookmarks"] as AnyObject?) as? [AnyObject]
                self.bookmarks = self.parseBookmarks(bookmarksJSON)
            }
            block?(error)
        })
    }

    func parseBookmarks(bookmarksJSON: [AnyObject]!) -> [Bookmark] {
        var bookmarks: [Bookmark] = []

        for obj in bookmarksJSON {
            if let bookmark = obj as? [String: AnyObject] {
                bookmarks.append(Bookmark(JSONDictionary: bookmark))
            }
        }

        return bookmarks
    }
}
