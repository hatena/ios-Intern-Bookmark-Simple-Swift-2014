//
//  Entry.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/03.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

struct Entry: Printable {

    let entryID: NSNumber?
    let URL: NSURL?
    let title: String?
    let created: NSDate?
    let updated: NSDate?

    var description: String {
        return "<entryID=\(entryID)"
            + ", URL=\(URL)"
            + ", title=\(title)"
            + ", created=\(created), updated=\(updated)>"
    }

    init(JSONDictionary json: [String: AnyObject]) {
        if let entryID = json["entry_id"] as? NSNumber {
            self.entryID = entryID
        }
        if let URL = json["url"] as? String {
            self.URL = NSURL(string: URL)
        }
        if let title = json["title"] as? String {
            self.title = title
        }

        let dateFormatter: NSDateFormatter = NSDateFormatter.MySQLDateFormatter();

        if let created = json["created"] as? String {
            self.created = dateFormatter.dateFromString(created)
        }
        if let updated = json["updated"] as? String {
            self.updated = dateFormatter.dateFromString(updated)
        }
    }
}
