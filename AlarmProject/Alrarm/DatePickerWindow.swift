//
//  DatePicker.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/27.
//

import Foundation
import SwiftUI
import UserNotifications
import UserNotificationsUI
import AVKit
import AVFoundation



extension View {
  @ViewBuilder func applyTextColor(_ color: Color) -> some View {
    if UITraitCollection.current.userInterfaceStyle == .light {
      self.colorInvert().colorMultiply(color)
    } else {
      self.colorMultiply(color)
    }
  }
}

struct DatePickerWindow:View{
    
    @State private var wakeup = Date()
    @State private var save:Bool = false
    @State private var pushTime=String()
    @State private var pushTimeString=String()
    @State private var alarmList:Array<String> = []
    @State private var alarmListInterval:Array<Int> = []
    @State private var item:Int = 0
    @State private var currentTime=String()
    @State var content: String = ""
    @State var currentDate = Date()
    @State var repeatMode:Bool = false
    @State var repeatImage = "repeat.1.circle.fill"
    
    
    @Environment(\.managedObjectContext) var mac
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
   
    
   
    var body: some View{
        VStack{
            //Spacer().frame(height: 20)
            DatePicker("", selection: $wakeup,displayedComponents: .hourAndMinute).applyTextColor(.white)
                .datePickerStyle(WheelDatePickerStyle()).labelsHidden().padding().opacity(1.0).cornerRadius(20)
            HStack(spacing: 5){
                
                TextField("", text: $content)
                    .padding(.horizontal)
                    .padding(.vertical,5)
                    .background(.white.opacity(0.2))
                    .cornerRadius(10)
                Button(action: {

                    
                    alarmList.append(FormatterClass.init().dateFormatter.string(from: wakeup))
                    currentTime = FormatterClass.init().yearsettingFormatter.string(from: wakeup)
                    pushTimeString = alarmList[item]
                    alarmList.sort()
                    
                 
                    self.item += 1
                    self.save = true
                    
                    let time = Entity(context:mac)
                    time.alarmText = content
                    time.time = pushTimeString
                    try? mac.save()



                    var useTime:Int
                    guard let startTime:Date = FormatterClass.init().yearFormatter.date(from: FormatterClass.init().yearFormatter.string(from: currentDate)) else {return}
                    guard let endTime:Date = FormatterClass.init().yearsettingFormatter.date(from: self.currentTime)  else {return}
                    
                    if startTime >= endTime{
                        useTime = Int((endTime + 86400).timeIntervalSince(startTime))-4
                    }else{
                        useTime = Int(endTime.timeIntervalSince(startTime))-4
                    }
                    
                    alarmListInterval.append(useTime)
                    alarmListInterval.sort()
                    
                    AlertAlarm().alertalram(timeinterval: alarmListInterval[alarmListInterval.count-1],listName: time.alarmText ?? "", listTime: String(FormatterClass.init().dateFormatter.string(from: wakeup)),repeatAlret: repeatMode)
        
                }){
                    Text("저장").fontWeight(.black).foregroundColor(.white).padding(5)
                }.alert(isPresented: $save){
                    Alert(title: Text("알람이 저장 되었습니다!"))
                }
            
            }.padding(10)
        }.foregroundColor(.white)
    }
}
struct DatePickerWindow_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerWindow().background(.black)
    }
}
