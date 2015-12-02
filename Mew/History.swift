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
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewDidLayoutSubviews()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"reloadTable", name:
            "HistoryReload", object: nil)

        self.performSelector("reloadTable", withObject: nil, afterDelay: 0.1)

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func reloadTable(){
        tbl_History!.reloadInputViews()
        tbl_History!.reloadData()
    }
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.reloadTable()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let nibName : UINib = UINib(nibName: "HistoryCell", bundle: nil)
        tableView.registerNib(nibName, forCellReuseIdentifier: "Cell")

        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HistorySelection.selectedInfo.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCellWithIdentifier("Cell") as! HistoryCell
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
            imageView.contentMode = UIViewContentMode.ScaleToFill
            imageView.clipsToBounds = true
            imageView.image = (images.objectAtIndex(i) as! UIImage)
            imageView.frame = CGRectMake(x, y, (self.view.frame.size.width/2), 113)
            imageView.setNeedsDisplay()
            cell.setNeedsDisplay()
            print(vw_imgcontainer)
            print(self.view.frame)
            print(imageView)
                        x = x + (self.view.frame.size.width/2)
        }
        
        
        return cell
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300;
 
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
