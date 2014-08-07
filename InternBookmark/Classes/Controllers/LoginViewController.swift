//
//  LoginViewController.swift
//  InternBookmark
//
//  Created by sakahara on 2014/08/04.
//  Copyright (c) 2014年 Hatena Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let request: NSURLRequest = NSURLRequest(URL: InternBookmarkAPIClient.loginURL())
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func webViewDidStartLoad(webView: UIWebView!) {
        AFNetworkActivityIndicatorManager.sharedManager().incrementActivityCount()
    }

    func webViewDidFinishLoad(webView: UIWebView!) {
        AFNetworkActivityIndicatorManager.sharedManager().decrementActivityCount()
    }

    func webView(webView: UIWebView!, didFailLoadWithError error: NSError!) {
        AFNetworkActivityIndicatorManager.sharedManager().decrementActivityCount()
        if (error.code != NSURLErrorCancelled) {
            let alertController : UIAlertController = UIAlertController(error: error)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}
