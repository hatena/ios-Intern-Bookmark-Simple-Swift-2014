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

        if let optionTitles = error.localizedRecoveryOptions as? [String] {
            for title in optionTitles {
                let action = UIAlertAction(title: title, style: .Default, handler: nil)
                self.addAction(action)
            }
        }
    }
}
