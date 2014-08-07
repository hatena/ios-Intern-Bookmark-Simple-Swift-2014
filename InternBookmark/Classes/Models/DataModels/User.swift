//
//  User.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/03.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

class User: NSObject {
    var userID: NSNumber!
    var name: String!
    var created: NSDate!

    convenience init(JSONDictionary json: Dictionary<String, AnyObject>!) {
        let userID: NSNumber! = json["user_id"] as? NSNumber
        let name: String! = json["name"] as? NSString

        let dateFormatter: NSDateFormatter = NSDateFormatter.MySQLDateFormatter()
        let created: NSDate = dateFormatter.dateFromString(json["created"] as? NSString)

        return self.init(userID: userID, name: name, created: created)
    }

    init(userID: NSNumber!, name: String!, created: NSDate!) {
        self.userID = userID
        self.name = name
        self.created = created
    }

    func description() -> String {
        var description: String = "<\(NSStringFromClass(self.dynamicType)): "
            + "self.userID=\(self.userID)"
            + ", self.name=\(self.name)"
            + ", self.created=\(self.created)>"
        return description
    }
}
