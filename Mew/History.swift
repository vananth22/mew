//
//  History.swift
//  Mew
//
//  Copyright © 2015 Mew. All rights reserved.
//

import UIKit

class History: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tbl_History:UITableView?
    
    var HistorySelection = PhotoShare.sharedInstance

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.reloadInputViews()
        tbl_History!.reloadData()
        tbl_History!.reloadInputViews()
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
            var selNames = NSString()
            
            for (var j = 0; j<names.count; j++) {
                selNames = (selNames as String) + ", " + (names.objectAtIndex(j) as! String)
            }
            lbl_name.text = selNames as String
            
            for (var i = 0; i < (images.count); i++) {

                let vw_holderframe = vw_imgcontainer?.frame as CGRect?
                
                var y:CGFloat = 0.0
                var x:CGFloat = 0.0
                if(i > 1)
                {
                    y = (vw_holderframe?.height)! / 2
                }
                if(i%2==0)
                {
                    x = (vw_holderframe?.width)!/2
                }
                var imageView : UIImageView
                imageView  = UIImageView(frame:CGRectMake(x, y, (vw_holderframe?.width)!/2, (vw_holderframe?.height)!/2));
                imageView.contentMode = UIViewContentMode.ScaleToFill
                imageView.clipsToBounds = true
                let img = images.objectAtIndex(i) as! UIImage
                imageView.image = img
//                imageView.clipsToBounds = true
//                imageView.contentMode = UIViewContentMode.ScaleAspectFit
                vw_imgcontainer?.addSubview(imageView)
            }

        
        return cell

    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300;
    }
}
