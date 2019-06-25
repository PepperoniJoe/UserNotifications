//
//  ViewController.swift
//  UserNotification
//
//  Created by Marcy Vernon on 6/21/19.
//  Copyright © 2019 Marcy Vernon. All rights reserved.
//

import UIKit
import UserNotifications

class NotifyViewController: UIViewController {
  
  let content = UNMutableNotificationContent()
  let center  = UNUserNotificationCenter.current()

  @IBOutlet weak var notifyDescription: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    requestNotifyAuthorization()
  }
  
  @IBAction func start5minutes(_ sender: UIButton) {
    setupAlert()
    notifyDescription.text = "5-minute alarm has been set"
  }
  
  func setupAlert() {
    // Set up the notification alert
    content.title = NSString.localizedUserNotificationString(forKey: "Alert", arguments: nil)
    content.body  = NSString.localizedUserNotificationString(forKey: "5 minutes have passed!", arguments: nil)
    
    let alertDate = addTimeToCurrentDate(timeType: .minute, value: 5)
    let trigger = UNCalendarNotificationTrigger(dateMatching: alertDate, repeats: false)
    let request = UNNotificationRequest(identifier: "5-minute Alert", content: content, trigger: trigger)
    
    center.add(request) { (error : Error?) in
      if let error = error {
        print(error.localizedDescription)
      }
    }
  }
  
  func addTimeToCurrentDate(timeType: Calendar.Component, value: Int) -> DateComponents {
    // Gets current date and adds time to determine notification scheduled time
    var dateInfo  = DateComponents()
    let startDate = Date()
    let calendar  = Calendar.current
    if let date = calendar.date(byAdding: timeType, value: value, to: startDate) {
      dateInfo.day       = calendar.component(.day, from: date)
      dateInfo.hour      = calendar.component(.hour, from: date)
      dateInfo.minute    = calendar.component(.minute, from: date)
      dateInfo.second    = calendar.component(.second, from: date)
    }
    //print(dateInfo)
    return dateInfo
  }
  
  func requestNotifyAuthorization() {
    // Request permission to display alerts and play sounds.
    center.requestAuthorization(options: [.alert, .sound])
    { (granted, error) in
      if !granted {
        print("Request not granted.")
      }
      if let error = error {
        print(error.localizedDescription)
      }
    }
  }
}



