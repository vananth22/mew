
//
//  File.swift
//  Mew
//
//  Created by Karthikeyan on 10/24/15.
//  Copyright © 2015 Anish Kaliraj. All rights reserved.
//

import Foundation
//
//  ClientServerCommunication.swift
//  Parent
//
//  Created by Karthikeyan on 9/22/15.
//  Copyright © 2015 Karthikeyan. All rights reserved.
//

import Foundation
import Alamofire
import PKHUD

class ServerCommunication {
    
    func createURLFor(task:String) -> String{
        var strUrl = ""
        switch(task)
        {
        case "signUpSend":
            strUrl = "\(SERVER)\(APPPATH)\(SEND_PATH)"
            return strUrl
        case "signUpVaidate":
            strUrl = "\(SERVER)\(APPPATH)\(VALIDATE_PATH)"
            return strUrl

        default :
            return strUrl
        }
        return strUrl
        
    }
    
    func communicateServerFor(Module:String, withNumber:String) -> Alamofire.Request{
        let URL = "\(self.createURLFor(Module))/\(withNumber)"
        return   Alamofire.request(.GET, URL, parameters: nil,headers:nil)
    }
    
    
    //MARK: Loading HUD
    func showHud(){
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        //        PKHUD.sharedHUD.dimsBackground = true
        
    }
    func hideHud(){
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.hide(afterDelay: 0.0)
        }
    }
    func showSuccess(){
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            PKHUD.sharedHUD.contentView = PKHUDSuccessView()
            PKHUD.sharedHUD.hide(afterDelay: 1.0)
        }
    }
}