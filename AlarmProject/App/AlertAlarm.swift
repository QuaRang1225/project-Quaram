//
//  AlertAlarm.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/27.
//

import Foundation
import SwiftUI

class AlertAlarm{
    
  
    
    static func alertalram(timeinterval:Int,alarm:AlarmData){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert ,.badge,.sound]){ success, error in
            if success{
                print("허용")
            }else if let error = error{
                print(error.localizedDescription)
            }
        }
        let content = UNMutableNotificationContent()
        
        content.title = alarm.title == "" ? "알람" : alarm.title
        content.subtitle = "예약 시간 \(alarm.time)"
        content.sound = UNNotificationSound.default
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeinterval)-1, repeats: false)
        let request = UNNotificationRequest(identifier: alarm.id, content: content, trigger: triger)
        UNUserNotificationCenter.current().add(request){ (err) in
            if err != nil{
                print("에러")
            }
        }
    }
    
    static func caancelAlarm(id:String){

        let center = UNUserNotificationCenter.current()
        center.removeDeliveredNotifications(withIdentifiers: [id])
        center.removePendingNotificationRequests(withIdentifiers: [id])
        
    }
    
}
