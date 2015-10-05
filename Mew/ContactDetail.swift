//
//  ContactDetail.swift
//  Mew
//
//  Copyright © 2015 Mew. All rights reserved.
//

import UIKit
class ContactDetail: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet var lbl_Name:UILabel?
    internal var contactName :NSString!
    @IBOutlet weak var tbl_contactDetail : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None

    }
    override func viewWillLayoutSubviews() {

        tbl_contactDetail.reloadData()
        tbl_contactDetail.reloadInputViews()

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    
        lbl_Name!.text = contactName as String
        self.reloadInputViews()
      
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell :UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        let img_view: UIImageView = cell.viewWithTag(11) as! UIImageView
        
        img_view.image = UIImage(named: "1.png")
        switch (indexPath.row)
        {
        case 0:
            let cell1 :UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
            
            let img_view: UIImageView = cell1.viewWithTag(11) as! UIImageView
            
            img_view.image = UIImage(named: "2.png")

            return cell1
            
        case 1:
            
            let cell2 :UITableViewCell = tableView.dequeueReusableCellWithIdentifier("MultiCell")!
            let vw_imgcontainer = cell2.viewWithTag(30)

            var x: CGFloat = 0.0
            var y: CGFloat = 0.0
            
            for (var i = 0; i < 4; i++) {
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
//                imageView.image = (images.objectAtIndex(i) as! UIImage)
                x = x + (self.view.frame.size.width/2)
                }
        return cell2
                
            
        default :
            return cell
        }

    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }

    
}



