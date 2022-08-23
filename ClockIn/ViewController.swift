//
//  ViewController.swift
//  ClockIn
//
//  Created by 张得丑 on 2022/8/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 2...6 {
            sendNotification(title: "上班打卡", body: "记得打卡", hour: 8, minute: 25, weekday: index)
            sendNotification(title: "下班打卡", body: "记得打卡", hour: 17, minute: 35, weekday: index)
        }
        
        
        sendNotification(title: "漕运", body: "发初级", hour: 9, minute: 10, weekday: 0)
        sendNotification(title: "漕运", body: "收初级", hour: 11, minute: 10, weekday: 0)
        
        sendNotification(title: "运送", body: "5级", hour: 12, minute: 0, weekday: 0)
        
        sendNotification(title: "漕运", body: "发高级", hour: 14, minute: 10, weekday: 0)
        sendNotification(title: "漕运", body: "收高级", hour: 16, minute: 10, weekday: 0)
        
        sendNotification(title: "漕运", body: "发中级", hour: 17, minute: 10, weekday: 0)
        sendNotification(title: "漕运", body: "收中级", hour: 19, minute: 10, weekday: 0)
        
        sendNotification(title: "狩猎", body: "收狩猎", hour: 20, minute: 0, weekday: 0)
        
    }

    public func sendNotification(title : String, body: String, hour: Int, minute: Int, weekday: Int) {
        // //取消所有的本地通知
//        UIApplication.sharedApplication.ncelAllLocalNotifications()
//        //数字清零
//        UIApplication.sharedApplication.plicationIconBadgeNumber = 0
        
        if #available(iOS 10, *) {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.userInfo = [:]
            
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            var matchingDate = DateComponents()
            if (weekday > 0) {
                matchingDate.weekday = weekday
            }
            matchingDate.hour = hour
            matchingDate.minute = minute
            let trigger = UNCalendarNotificationTrigger(dateMatching: matchingDate, repeats: true)
            // Create the request
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                        content: content, trigger: trigger)

            // Schedule the request with the system.
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { (error) in
               if error != nil {
                  // Handle any errors.
               }
            }
        }
    }

}

