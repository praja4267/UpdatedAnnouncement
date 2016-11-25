//
//  WebServices.swift
//  Announcements
//
//  Created by Active Mac05 on 25/11/16.
//  Copyright © 2016 techactive. All rights reserved.
//

import Foundation
import Foundation

class WebServices: NSObject {
    let request: NSMutableURLRequest
    init(method: String, url: String) {
        self.request = NSMutableURLRequest(URL: NSURL(string: url)!)
        self.request.HTTPMethod = method
    }
    
    func getJsonData(callback: (Array<Announcement>) -> ()) {
        let session = NSURLSession.sharedSession()
        var dataTask = NSURLSessionDataTask()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            dataTask = session.dataTaskWithRequest(self.request) { (data, response, error) in
                if (error == nil) {
                    var callbackArray = Array<Announcement>()
                    
                    do{
                        let responseArray = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSArray
                        for item: AnyObject in responseArray {
                            let tempAnnounce = Announcement()
                            tempAnnounce.announce_id = item.valueForKey("ID") as! String
                            tempAnnounce.announce_date = item.valueForKey("ANNOUNCEMENT_DATE") as! String
                            tempAnnounce.announce_title = item.valueForKey("ANNOUNCEMENT_TITLE") as! String
                            tempAnnounce.announce_image = item.valueForKey("ANNOUNCEMENT_IMAGE") as! String
                            tempAnnounce.announce_description = item.valueForKey("ANNOUNCEMENT_DESCRIPTION") as! String
                            tempAnnounce.announce_html = item.valueForKey("ANNOUNCEMENT_HTML") as! String
                            //                        var arrayItem = Announcement(dict: item as NSDictionary)
                            callbackArray.append(tempAnnounce)
                        }
                        
                    }catch{
                        
                    }
                    
                    callback(callbackArray)
                } else {
                    // handle an error
                }
            }
            dataTask.resume()
        }
    }
}
