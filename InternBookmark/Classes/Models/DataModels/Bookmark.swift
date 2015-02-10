//
//  Bookmark.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/03.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

struct Bookmark {

    let bookmarkID: NSNumber?
    let comment: String?
    let entry: Entry?
    let user: User?
    let created: NSDate?
    let updated: NSDate?

    var description: String {
        return "<bookmarkID=\(bookmarkID)"
            + ", comment=\(comment)"
            + ", entry=\(entry)"
            //+ ", user=\(user)"
            + ", created=\(created)"
            + ", updated=\(updated)>"
    }

    init(JSONDictionary json: [String: AnyObject]) {
        if let bookmarkID = json["bookmark_id"] as? NSNumber {
            self.bookmarkID = bookmarkID
        }
        if let comment = json["comment"] as? NSString {
            self.comment = comment
        }

        let dateFormatter = NSDateFormatter.MySQLDateFormatter()

        if let created = json["created"] as? NSString {
            self.created = dateFormatter.dateFromString(created)
        }
        if let updated = json["updated"] as? NSString {
            self.updated = dateFormatter.dateFromString(updated)
        }
        if let entry = json["entry"] as? [String: AnyObject] {
            self.entry = Entry(JSONDictionary: entry)
        }
        if let user = json["user"] as? [String: AnyObject] {
            self.user = User(JSONDictionary: user)
        }
    }
}
