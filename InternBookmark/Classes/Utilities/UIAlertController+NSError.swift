//
//  UIAlertController+NSError.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/05.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

extension UIAlertController {
    convenience init(error : NSError) {

        let message = "\n".join([error.localizedFailureReason ?? "", error.localizedRecoverySuggestion ?? ""])
        self.init(title: error.localizedDescription, message: message, preferredStyle: .Alert)

        let optionTitles = error.localizedRecoveryOptions

        if (optionTitles?.count > 0) {
            for title: AnyObject! in optionTitles! {
                let action = UIAlertAction(title: title as String, style: .Default, handler: nil)
                self.addAction(action)
            }
        }
    }
}
