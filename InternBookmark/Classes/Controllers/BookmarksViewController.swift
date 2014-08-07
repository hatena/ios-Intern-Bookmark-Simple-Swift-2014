//
//  BookmarksViewController.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/03.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

class BookmarksViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refreshBookmarks:", forControlEvents: UIControlEvents.ValueChanged)

        self.refreshBookmarks(self)
    }

    func refreshBookmarks(sender: AnyObject) {
        self.refreshControl.beginRefreshing()

        BookmarkManager.sharedManager().reloadBookmarksWithBlock( { (error: NSError!) in
            if (error) {
                println("error = %@", error)
            }
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
        return BookmarkManager.sharedManager().bookmarks.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookmarkCell", forIndexPath: indexPath) as UITableViewCell

        let bookmark: Bookmark = BookmarkManager.sharedManager().bookmarks[indexPath.row]

        cell.textLabel.text = bookmark.entry.title
        cell.detailTextLabel.text = bookmark.entry.URL.absoluteString

        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "OpenBookmarkSegue") {
            let selected: NSIndexPath = self.tableView.indexPathForSelectedRow()
            let bookmark: Bookmark = BookmarkManager.sharedManager().bookmarks[selected.row]

            let bookmarkViewController: BookmarkViewController = segue.destinationViewController as BookmarkViewController
            bookmarkViewController.bookmark = bookmark
        }
    }

    // MARK: - IBAction

    @IBAction func closeLoginSegue(segue: UIStoryboardSegue) {
        self.refreshBookmarks(self)
    }
}
