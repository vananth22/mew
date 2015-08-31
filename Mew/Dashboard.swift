//
//  Dashboard.swift
//  Mew
//
//  Created by Karthikeyan on 8/30/15.
//  Copyright (c) 2015 Anish Kaliraj. All rights reserved.
//

import Foundation
import UIKit


class Dashboard : UIViewController,UITableViewDataSource, UITableViewDelegate {
    let NamesArray = ["Smith Johnson","Jones Wilson","Adams Green"]
    let img_names = ["1.png","2.png","3.png","4.png","5.png","6.png","7.png"]
    @IBOutlet var tbl_dashboard: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.reloadInputViews()
        tbl_dashboard.reloadData()
        tbl_dashboard.reloadInputViews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return NamesArray.count
    }
    
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        var lbl_name = cell.viewWithTag(13) as! UILabel
        lbl_name.text = NamesArray[indexPath.row]
        
        switch (indexPath.row) {
        case 0:
            var vw_imgcontainer = cell.viewWithTag(30)
            
            for i in 0 ... 3 {
                var vw_holderframe = vw_imgcontainer?.frame as CGRect?
                
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
                imageView.image = UIImage(named:img_names[i])
                vw_imgcontainer?.addSubview(imageView)
            }
            break;
        case 1:
            var vw_imgcontainer = cell.viewWithTag(30)
            for i in 0 ... 1 {
                var vw_holderframe = vw_imgcontainer?.frame as CGRect?
                
                var y:CGFloat = 0.0
                var x:CGFloat = 0.0
                if(i == 1)
                {
                    x = (vw_holderframe?.width)!/2
                }
                var imageView : UIImageView
                imageView  = UIImageView(frame:CGRectMake(x, y, (vw_holderframe?.width)!/2, (vw_holderframe?.height)!));
                imageView.contentMode = UIViewContentMode.ScaleToFill
                imageView.clipsToBounds = true
                imageView.image = UIImage(named:img_names[i+4])
                vw_imgcontainer?.addSubview(imageView)
            }
            break;
        case 2:
            var vw_imgcontainer = cell.viewWithTag(30)
            var vw_holderframe = vw_imgcontainer?.frame as CGRect?
            
            var y:CGFloat = 0.0
            var x:CGFloat = 0.0
            
            var imageView : UIImageView
            imageView  = UIImageView(frame:CGRectMake(x, y, (vw_holderframe?.width)!, (vw_holderframe?.height)!));
            imageView.contentMode = UIViewContentMode.ScaleToFill
            imageView.clipsToBounds = true
            imageView.image = UIImage(named:"7.png")
            vw_imgcontainer?.addSubview(imageView)
            
            break;
            
        default:
            break;
        }
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if (indexPath.row == 0)
        {
            return 300.0
        }
        if (indexPath.row == 1)
        {
            return 300.0
        }
        if (indexPath.row == 2)
        {
            return 300.0
        }
        
        return 0
    }

}
