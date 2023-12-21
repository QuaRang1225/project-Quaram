//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI

struct TimerCount:View{
    @StateObject var timerClass = TimerClass()
    
    @State var hourSelction = 0
    @State var minuteSelction = 0
    @State var secondSelction = 0
    
    @Environment(\.scenePhase) var scenePhase
    @State var timeRemaining: Double = 0
    @State private var totalTime: Double = 0
    @State private var startTime = Date()
    @State private var stopTime = Date()
//    }
    var body: some View{
        ZStack(alignment: .topLeading){
                
            VStack{
                timeText
                timePicker
                playButton
            }
            .padding(.bottom)
            .onChange(of: scenePhase) { newValue in
                switch newValue {
                case .active:
                    bgTimer()
                default: return
                }
            }
            .frame(maxHeight: .infinity,alignment: .center)
           
        }.background{
            Image("NIGHT")
                .resizable()
                .ignoresSafeArea()
        }.navigationBarBackButtonHidden(true)
        
    }
    func getTimeString(time: Double) -> String {
        let hour = Int(time) / 3600 % 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i : %02i : %02i",hour, minutes, seconds)
    }
    func bgTimer() {
        //activeMode일때 타이머가 0이면 카운트를 0으로 설정
        guard timerClass.timeElapsed >= 0 else { return timerClass.timeElapsed = 0 }
        
        //타이머 작동 했던 시간과 현재 시간사이의 시간차이를 초단위로 계산함
        let curTime = Date.now
        let diffTime = curTime.distance(to: startTime)
        let result = Double(diffTime.formatted())!
        
        //타이머가 유효하고 일시정시 상태가 아닐때 가장 처음에 설정한 시간에서 이 메서드가 호출된 시점 즉 active모드 진입 시까지의 시간을 빼서 시간차이를 계산
        print(timerClass.stopMode)
        if !timerClass.timer.isValid,timerClass.stopMode != .pause{
            timerClass.timeElapsed = totalTime + result
        }
        
        
    }
    var timeText:some View{
        Text(getTimeString(time: ceil(timerClass.timeElapsed)))
            .font(.system(size: 50))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding()
            .padding(.top)
    }
    var timePicker:some View{
        HStack(spacing:0){
            Picker(selection: self.$hourSelction, label: Text("")){
                ForEach(0..<24,id: \.self){ index in
                    Text("\(index)시간")
                }
            }
            Picker(selection: self.$minuteSelction, label: Text("")){
                ForEach(0..<60,id: \.self){ index in
                    Text("\(index)분")
                }
            }
            Picker(selection: self.$secondSelction, label: Text("")){
                ForEach(0..<60,id: \.self){ index in
                    Text("\(index)초")
                }
            }
        }
        .pickerStyle(.wheel)
        .environment(\.colorScheme,.dark)
    
    }
    var playButton:some View{
        HStack{
            Button {
                switch timerClass.stopMode{
                case .stop:
                    timerClass.start()
                    timerClass.timeElapsed = Double(hourSelction * 3600 + minuteSelction * 60 + secondSelction)
                    totalTime = timerClass.timeElapsed
                   
                    if totalTime > 0{
                        startTime = Date.now
                        AlertTimer().alretTimer(timeinterval: totalTime, timeName: getTimeString(time: totalTime))
                    }
                case .run:
                    timerClass.pause()
                    stopTime = Date.now
                    AlertTimer().caancelAlarm()
                case .pause:
                    timerClass.start()
                    startTime = stopTime
                    AlertTimer().alretTimer(timeinterval: timerClass.timeElapsed, timeName: getTimeString(time: totalTime))
                }
            } label: {
                Image(systemName: timerClass.stopMode.image)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
            }
            Spacer().frame(width: 30)
            Button(action: {
                timerClass.stop()
                AlertTimer().caancelAlarm()
            }){
                StopWatchButton(image: "stop.fill")
            }
        }
        .padding(.horizontal,120)
    }
}
struct TimerCount_Previews: PreviewProvider {
    static var previews: some View {
        TimerCount().environmentObject(TimerClass())
    }
}
