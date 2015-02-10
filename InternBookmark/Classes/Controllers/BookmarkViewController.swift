//
//  BookmarkViewController.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/04.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var URLLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    var bookmark : Bookmark!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.bookmark.entry?.title
        self.titleLabel.text = self.bookmark.entry?.title
        self.URLLabel.text = self.bookmark.entry?.URL?.absoluteString
        self.commentLabel.text = self.bookmark.comment
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
