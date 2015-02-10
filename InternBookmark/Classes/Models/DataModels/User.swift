//
//  User.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/03.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

struct User {
    let userID: NSNumber?
    let name: String?
    let created: NSDate?

    var description: String {
        return "<userID=\(userID)"
            + ", name=\(name)"
            + ", created=\(created)>"
    }

    init(JSONDictionary json: [String: AnyObject]) {
        if let userID = json["user_id"] as? NSNumber {
            self.userID = userID
        }
        if let name = json["name"] as? NSString {
            self.name = name
        }

        let dateFormatter: NSDateFormatter = NSDateFormatter.MySQLDateFormatter()
        if let created = json["created"] as? NSString {
            self.created = dateFormatter.dateFromString(created)
        }
    }
}
