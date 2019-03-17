//
//  AppDelegate.swift
//  L4STodo
//
//  Created by kai-munekuni on 2019/02/25.
//  Copyright © 2019年 kai-munekuni. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var distance: TimeInterval = 0 {
        didSet {
            print(distance)
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let calendar = Calendar(identifier: .gregorian)
        let preDay = UserDefaults.standard.integer(forKey: "toDay")
        let newDay = calendar.component(Calendar.Component.day, from: Date())
        UserDefaults.standard.register(defaults: ["goal":10])
        if preDay != newDay {
            UserDefaults.standard.set(newDay, forKey: "toDay")
            UserDefaults.standard.set(UserDefaults.standard.double(forKey: "playTime") + UserDefaults.standard.double(forKey: "sum"), forKey: "sum")
            UserDefaults.standard.set(0, forKey: "playTime")
        }
        
        let playTime = UserDefaults.standard.integer(forKey: "playTime")
        distance = TimeInterval(exactly: playTime) ?? 0
        
        // notification center (singleton)
        let center = UNUserNotificationCenter.current()
        center.delegate = self as? UNUserNotificationCenterDelegate
        // ------------------------------------
        // 前準備: ユーザに通知の許可を求める
        // ------------------------------------
        
        // request to notify for user
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Allowed")
            } else {
                print("Didn't allowed")
            }
        }
        return true
    }
    func setNotificaiton(){
        let time = UserDefaults.standard.integer(forKey: "playTime")
        let goal = UserDefaults.standard.integer(forKey: "goal")
        let center = UNUserNotificationCenter.current()
        print(time,goal)
        if time/60 > goal{
            center.removeAllPendingNotificationRequests()
            let now = NSDate()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH,mm"
            let string = formatter.string(from: now as Date).components(separatedBy: ",")
            var notificationTime = DateComponents()
            var trigger: UNNotificationTrigger
            notificationTime.hour = Int(string[0])
            notificationTime.minute = Int(string[1])
            trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
            let content = UNMutableNotificationContent()
            content.title = "タイトル"
            content.body = "アプリを開く時間です!"
            content.sound = UNNotificationSound.default
            var request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
            center.add(request, withCompletionHandler: nil)
            notificationTime.hour = notificationTime.hour! - 1
            trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
            request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
            center.add(request, withCompletionHandler: nil)
            notificationTime.hour = notificationTime.hour! - 1
            trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
            request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
            center.add(request, withCompletionHandler: nil)
        } else {
            let content = UNMutableNotificationContent()
            content.title = "リマインド"
            content.body = "アプリを開こう"
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2400, repeats: true)
            let request = UNNotificationRequest(identifier: "RepeatNotification",
                                                content: content,
                                                trigger: trigger)
            // ローカル通知予約
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        UserDefaults.standard.set(distance, forKey: "playTime")
        setNotificaiton()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the useinterface.
        distance = UserDefaults.standard.double(forKey: "playTime")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

