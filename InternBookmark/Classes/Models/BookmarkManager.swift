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

    func reloadBookmarksWithBlock(block: ((NSError!) -> Void)!) {
        InternBookmarkAPIClient.sharedClient().getBookmarksWithCompletion( { (results: AnyObject!, error: NSError!) in
            if (results) {
                let jsonResults: Dictionary<String, AnyObject>! = results as? Dictionary<String, AnyObject>
                let bookmarksJSON: Array<AnyObject>! = (jsonResults["bookmarks"] as AnyObject?) as? Array<AnyObject>
                self.bookmarks = self.parseBookmarks(bookmarksJSON)
            }
            if (block) {
                block(error)
            }
        })
    }

    func parseBookmarks(bookmarks: Array<AnyObject>!) -> Array<Bookmark> {
        var mutableBookmarks: Array<Bookmark> = []

        for obj in bookmarks {
            let bookmark: Bookmark = Bookmark(JSONDictionary: obj as? Dictionary<String, AnyObject>)
            mutableBookmarks.append(bookmark)
        }

        return mutableBookmarks
    }

}
