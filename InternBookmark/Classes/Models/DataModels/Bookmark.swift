//
//  Bookmark.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/03.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

class Bookmark: NSObject {

    var bookmarkID: NSNumber!
    var comment: String!
    var entry: Entry!
    var user: User!
    var created: NSDate!
    var updated: NSDate!

    convenience init(JSONDictionary json: Dictionary<String, AnyObject>!) {
        let bookmarkID: NSNumber! = json["bookmark_id"] as? NSNumber
        let comment: String! = json["comment"] as? NSString

        let dateFormatter: NSDateFormatter = NSDateFormatter.MySQLDateFormatter()

        let created: NSDate! = dateFormatter.dateFromString(json["created"] as? NSString)
        let updated: NSDate! = dateFormatter.dateFromString(json["updated"] as? NSString)

        let entry: Entry! = Entry(JSONDictionary: json["entry"]! as? Dictionary<String, AnyObject>)
        let user: User! = User(JSONDictionary: json["user"]! as? Dictionary<String, AnyObject>)

        return self.init(bookmarkID: bookmarkID, comment: comment, entry: entry, user: user, created: created, updated: updated)
    }

    init(bookmarkID: NSNumber!, comment: String!, entry: Entry!, user: User!, created: NSDate!, updated: NSDate!) {
        self.bookmarkID = bookmarkID
        self.comment = comment
        self.entry = entry
        self.user = user
        self.created = created
        self.updated = updated
    }

    func description() -> String {

        var description : String = "<\(NSStringFromClass(self.dynamicType)): "
            + "self.bookmarkID=\(self.bookmarkID)"
            + ", self.comment=\(self.comment)"
            + ", self.entry=\(self.entry)"
            + ", self.user=\(self.user)"
            + ", self.created=\(self.created)"
            + ", self.updated=\(self.updated)>"
        return description
    }
}
