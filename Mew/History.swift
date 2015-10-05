//
//  History.swift
//  Mew
//
//  Created by Anish Kaliraj on 9/19/15.
//  Copyright © 2015 Anish Kaliraj. All rights reserved.
//

import UIKit

class History: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tbl_History:UITableView?
    
    var HistorySelection = PhotoShare.sharedInstance
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.reloadInputViews()
        
    }
    override func viewWillLayoutSubviews() {
        tbl_History!.reloadInputViews()
        tbl_History!.reloadData()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HistorySelection.selectedInfo.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        let lbl_name = cell.viewWithTag(13) as! UILabel
        lbl_name.text = ""
        
        let lbl_comments = cell.viewWithTag(17) as! UILabel
        
        let dictInfo = HistorySelection.selectedInfo.objectAtIndex(indexPath.row) as! NSDictionary
        
        lbl_comments.text = dictInfo.valueForKey("comments") as? String
        let names = dictInfo.valueForKey("contacts") as! NSArray
        let images = dictInfo.valueForKey("images") as! NSArray
        
        let vw_imgcontainer = cell.viewWithTag(30)
        var selNames = String()
        
        for (var j = 0; j < names.count; j++) {
            selNames += (names.objectAtIndex(j) as! String)
            if(j < (names.count-1))
            {
                selNames += ","
            }
        }
        lbl_name.text = selNames as String
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        
        for (var i = 0; i < (images.count); i++) {
            if(i > 1)
            {
                y = (vw_imgcontainer!.frame.size.height)/2
                
            }
            if(i%2 == 0)
            {
                x = 0
            }
            let  imageView : UIImageView = vw_imgcontainer!.viewWithTag(1101+i) as! UIImageView
            imageView.frame = CGRectMake(x, y, (self.view.frame.size.width/2), (vw_imgcontainer!.frame.size.height)/2)
            imageView.contentMode = UIViewContentMode.ScaleToFill
            imageView.clipsToBounds = true
            imageView.image = (images.objectAtIndex(i) as! UIImage)
            x = x + (self.view.frame.size.width/2)
        }
        
        
        return cell
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300;
    }
}
