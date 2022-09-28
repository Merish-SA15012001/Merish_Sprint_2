//
//  LocalNotifyViewController.swift
//  Merish_Sprint_2
//
//  Created by Capgemini-DA202 on 9/25/22.
//

import UIKit
import NotificationFramework

class LocalNotifyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
    }
    

    @IBAction func notifybtn(_ sender: Any) {
        
        let notify = NotificationViewController()
        notify.replyNotification()
        notify.notification()
        
    }
}
