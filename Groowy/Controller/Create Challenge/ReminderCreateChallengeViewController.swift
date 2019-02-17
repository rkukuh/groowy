//
//  ReminderCreateChallengeViewController.swift
//  Groowy
//
//  Created by David-UC on 2/13/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import UserNotifications

class ReminderCreateChallengeViewController: SwipeFormViewController {

    var createChallengeController: CreateChallengeController?
    @IBOutlet weak var reminderPickerView: UIDatePicker!
    
    override func viewDidLoad() {
        registerNotification()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createChallengeController = createChallengeController {
            createChallengeController.didAddField(field: "reminder_at", value: "\(reminderPickerView.date)")
            
            if let segueDestination = segue.destination as? PromiseCreateChallengeViewController {
                segueDestination.createChallengeController = createChallengeController
                
            }
        }
    }
    
    func registerNotification() {
        
        // Register for Notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
            
        }
    }

   
}
