//
//  ViewController.swift
//  Announcements
//
//  Created by Active Mac05 on 25/11/16.
//  Copyright © 2016 techactive. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var announcementsListTV: UITableView!
    var announceList = [Announcement]()
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        announcementsListTV.dataSource = self
        announcementsListTV.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        announcementsListTV.tableFooterView = UIView()
        self.getAnnouncementInfo()
        announcementsListTV.estimatedRowHeight = 80.0
        announcementsListTV.rowHeight = UITableViewAutomaticDimension

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announceList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier: String = "Cell"
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)! as UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: CellIdentifier)
        }
        cell!.textLabel?.text = announceList[indexPath.row].announce_title
        cell!.detailTextLabel?.text =  announceList[indexPath.row].announce_date
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cntl  = self.storyboard?.instantiateViewControllerWithIdentifier("DetaiViewController") as! DetaiViewController
        cntl.htmlString = announceList[indexPath.row].announce_html
        cntl.navTitle = announceList[indexPath.row].announce_title
        self.navigationController?.pushViewController(cntl, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getAnnouncementInfo() {
        progressBarDisplayer("Getting data", true)
        let webservice = WebServices(method:"POST", url: "http://www.solutions4mobility.com/AABToyota/ipdp/ipdpb.ashx?CFG=OPTIMAL&p=Common.Announcements&Handler=News&MODULE_ID=501&TemplateName=News.htm&APPLICATION_NAME=TOYOTA&F=J")
        webservice.getJsonData { (array : Array<Announcement>) in
            self.announceList = array
            dispatch_async(dispatch_get_main_queue(), { 
                self.announcementsListTV.reloadData()
                self.messageFrame.removeFromSuperview()
            })
        }
    }
    
    
    
    func progressBarDisplayer(msg:String, _ indicator:Bool ) {
        print(msg)
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.whiteColor()
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 180, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
    }
    
}

