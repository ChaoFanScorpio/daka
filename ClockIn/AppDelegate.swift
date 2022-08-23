//
//  AppDelegate.swift
//  ClockIn
//
//  Created by 张得丑 on 2022/8/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 注册通知方法
        registerNotification(application)
        
//        sendNotification()
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
    // 注册通知方法
    func registerNotification(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted: Bool, error: Error?) in
                DispatchQueue.main.async {
                    if granted { application.registerForRemoteNotifications() }
                }
            }
        }
    }
    
    //添加本地推送和设置固定时间推送了
   
}


extension UIApplication {
    public static func localNotification(title: String, body: String, dateComponents: DateComponents? = nil, userInfo : [AnyHashable : Any]? = nil) {
        if #available(iOS 10, *) {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.userInfo = userInfo ?? [:]
        
            var trigger: UNNotificationTrigger?
            if let dataCompontnts = dateComponents {
                trigger = UNCalendarNotificationTrigger(dateMatching: dataCompontnts, repeats: false)
            }
        
            let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                //printLogDebug(error)
            })
        }
    }
    
    

        
        
        
 /*
        
        let localNotificationAM = UILocalNotification()
        //设置为5妙后localNotificationAM.fireDate = NSDate(timeIntervalSinceNow: 5)
        //早九点提醒上班打卡
        localNotificationAM.fireDate = getFireDate(9.0)
        localNotificationAM.repeatInterval = NSCalendarUnit.Day
        localNotificationAM.timeZone = NSTimeZone.defaultTimeZone()
        localNotificationAM.alertBody = "别忘上班打卡啊"
        localNotificationAM.applicationIconBadgeNumber =  1
        localNotificationAM.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotificationAM)
        
        let localNotificationPM = UILocalNotification()
        //下午6点提醒打卡
        localNotificationPM.fireDate = getFireDate(18.5)
        localNotificationAM.repeatInterval = NSCalendarUnit.Day
        localNotificationPM.timeZone = NSTimeZone.defaultTimeZone()
        localNotificationPM.alertBody = "别忘下班打卡和写日志啊"
        localNotificationPM.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        localNotificationPM.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotificationPM)
        print("@@@@@@@@@@@@@@@@@@注册上午和下午的本地通知 每天重复")
    }
  */
    //24小时制
//    func getFireDate( hourOfDay:Float)->NSDate{
//        //本地推送时间 hourOfDay
//        let pushTime: Float =  hourOfDay*60*60
//        let date = NSDate()
//        let dateFormatter = NSDateFormatter()
//        //日期格式为“时，分，秒”
//        dateFormatter.dateFormat = "HH,mm,ss"
//        //设备当前的时间（24小时制）
//        let strDate = dateFormatter.stringFromDate(date)
//        //将时、分、秒分割出来，放到一个数组
//        let dateArr = strDate.componentsSeparatedByString(",")
//        //统一转化成秒为单位
//        let hour = ((dateArr[0] as NSString).floatValue)*60*60
//        let minute = ((dateArr[1] as NSString).floatValue)*60
//        let second = (dateArr[2] as NSString).floatValue
//        var newPushTime = Float()
//        if hour > pushTime {
//            newPushTime = 24*60*60-(hour+minute+second)+pushTime
//        } else {
//            newPushTime = pushTime-(hour+minute+second)
//        }
//       return  NSDate(timeIntervalSinceNow: NSTimeInterval(newPushTime))
//    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        onResponseNotification(userInfo: response.notification.request.content.userInfo)
        completionHandler()
    }
}
    


