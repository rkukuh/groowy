//
//  CreateChallengeControllerViewController.swift
//  Groowy
//
//  Created by David-UC on 2/13/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class CreateChallengeController {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var data: [String: String] = [:]
    let dateFormatter = DateFormatter()
    var fetchedResults: NSFetchedResultsController<Challenge>!
    
    func didAddField(field: String, value: String) {
        // Get data from user input
        
        data[field] = value
    }
    
    func didPromiseTap() {
        // Persist to Core Data
        
        let challenge = Challenge(entity: Challenge.entity(), insertInto: context)
        
        challenge.title = data["title"]
        challenge.body = data["body"]
        challenge.goal = data["goal"]
        challenge.status = ChallengeStatus.progress.rawValue
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        if let date = dateFormatter.date(from: data["reminder_at"]!) {
            createLocalNotification(remindAt: date)
            challenge.remind_at = date as NSDate
        }
        
        appDelegate.saveContext()
    }
    
    
    
    func createLocalNotification(remindAt: Date) {
        let content = UNMutableNotificationContent()
        let name = User.name
        content.title = "Hi, \(name). Reflection Time! 😉"
        content.body = "It's a good time to reflect your challenge today!"
        content.sound = UNNotificationSound.default
        
        let now = Date()
        let sub = remindAt.timeIntervalSinceNow - now.timeIntervalSinceNow
        
        if sub > 0 {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: sub, repeats: false)
            let request = UNNotificationRequest(identifier: "reminder-challenge", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                
            }
        }
    }
}
