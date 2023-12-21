
//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI


struct Alarm:View{
    
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var currentDate = Date()
    @State private var setDate = Date()
    
    @State var content: String = ""
    @StateObject var alarmManager = AlarmContainerManager()

    var body: some View{
        ZStack{
            Image("NIGHT").resizable().edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                Text("알람")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                datePicker
                    
                    HStack(spacing: 5){
                        TextField("", text: $content)
                            .padding(.horizontal)
                            .padding(.vertical,5)
                            .background(.white.opacity(0.2))
                            .cornerRadius(10)
                        Button{
                            let newAlarm = AlarmData(title: content, time: FormatterClass.shared.HourminuteForMatter.string(from: setDate))
                            alarmManager.addData(alarm: newAlarm)
                            alertAlarm(alarm: newAlarm)
                            UIApplication.shared.endEditing()
                        } label: {
                            Text("저장")
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .padding(5)
                        }
                    }.padding(10)
                
                List{
                    ForEach(alarmManager.alarmList){ alarm in
                        AlarmList(time: alarm.time ?? "" ,content: alarm.title ?? "알람")
                            .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: alarmManager.deleteBooks)
                }.listStyle(PlainListStyle())
            }
        }
        .foregroundStyle(.white)
        .onReceive(timer) { input in
            self.currentDate = input
               
       }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
            
    }
    var datePicker:some View{
        VStack(alignment:.leading){
            Text("시간을 설정해주세요.")
                .padding(.leading)
                .padding(.top,10)
            
            DatePicker("", selection: $setDate,displayedComponents: .hourAndMinute)
                .environment(\.colorScheme,.dark)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .frame(maxWidth: .infinity)
        }
    }
    func alertAlarm(alarm:AlarmData){
        var timeDifference:Int? = nil
        
        //날짜 -> 문자열
        let currentTime = FormatterClass.shared.yearFormatter.string(from: currentDate)
        let setTime = FormatterClass.shared.yearsettingFormatter.string(from: setDate)
        
        //문자열 -> 날짜
        guard let startTime:Date = FormatterClass.shared.yearFormatter.date(from: currentTime) else {return}
        guard let endTime:Date = FormatterClass.shared.yearFormatter.date(from: setTime)  else {return}
        
        timeDifference = startTime >= endTime ? Int((endTime + 86400).timeIntervalSince(startTime)) : Int(endTime.timeIntervalSince(startTime))
        AlertAlarm.alertalram(timeinterval: timeDifference ?? 0, alarm: alarm)
    }
}
struct Alarm_Previews: PreviewProvider {
    static var previews: some View {
        Alarm()
    }
}

