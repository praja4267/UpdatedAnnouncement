//
//  DetaiViewController.swift
//  Announcements
//
//  Created by Active Mac05 on 25/11/16.
//  Copyright © 2016 techactive. All rights reserved.
//

import UIKit

class DetaiViewController: UIViewController {

    @IBOutlet var detailWebView: UIWebView!
    var htmlString = ""
    var navTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = navTitle
        detailWebView.loadHTMLString(htmlString, baseURL: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
