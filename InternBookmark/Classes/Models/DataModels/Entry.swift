//
//  Entry.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/03.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

class Entry: NSObject {

    var entryID: NSNumber!
    var URL: NSURL!
    var title: String!
    var created: NSDate!
    var updated: NSDate!

    convenience init(JSONDictionary json: Dictionary<String, AnyObject>!) {
        let entryID: NSNumber! = json["entry_id"] as? NSNumber
        let URL: NSURL! = NSURL.URLWithString(json["url"] as? NSString)
        let title: String! = json["title"] as? NSString

        let dateFormatter: NSDateFormatter = NSDateFormatter.MySQLDateFormatter();

        let created: NSDate! = dateFormatter.dateFromString(json["created"] as? NSString)
        let updated: NSDate! = dateFormatter.dateFromString(json["updated"] as? NSString)

        return self.init(entryID: entryID, URL: URL, title: title, created: created, updated: updated)
    }

    init(entryID: NSNumber!, URL: NSURL!, title: String!, created: NSDate!, updated: NSDate!) {
        self.entryID = entryID
        self.URL = URL
        self.title = title
        self.created = created
        self.updated = updated
    }

    func description() -> String {
        var description : String = "<\(NSStringFromClass(self.dynamicType)): "
            + "self.entryID=\(self.entryID)"
            + ", self.URL=\(self.URL)"
            + ", self.title=\(self.title)"
            + ", self.created=\(self.created)"
            + ", self.updated=\(self.updated)>"
        return description;
    }
}
