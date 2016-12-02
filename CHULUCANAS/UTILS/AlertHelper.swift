//
//  AlertHelper.swift
//  CHULUCANAS
//
//  Created by ucweb on 24/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
    
    //MARK: Simple Notification Alert
    class func notificationAlert(title: String, message:String, viewController : UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let successAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            //NSLog("OK Pressed")
        }
        
        alertController.addAction(successAction)
        
        viewController.present(alertController, animated: true, completion:nil)
    }
    
    //MARK: ConfirmRestore Notification Alert
    class func confirmRestore(title: String, message:String, viewController : UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let successAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { action -> Void in
            
            
            viewController.dismiss(animated: true, completion: nil)
            
        }
                
        
        alertController.addAction(successAction)
        
        viewController.present(alertController, animated: true, completion:nil)
    }
    
}
