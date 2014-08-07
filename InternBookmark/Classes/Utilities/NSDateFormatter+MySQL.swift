//
//  NSDateFormatter+MySQL.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/03.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

extension NSDateFormatter {
    class func MySQLDateFormatter() -> NSDateFormatter {
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT")
        formatter.locale = NSLocale(localeIdentifier:"en_US")
        formatter.calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
}