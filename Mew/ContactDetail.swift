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
    override func viewDidLoad() {
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    
        lbl_Name!.text = contactName as String
    

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
        
        return cell
    }

    
}



