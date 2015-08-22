//
//  ViewController.swift
//  Mew
//
//  Created by Anish Kaliraj on 27/07/15.
//  Copyright (c) 2015 Anish Kaliraj. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        goButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

