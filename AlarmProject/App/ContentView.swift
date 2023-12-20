//
//  ContentView.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import SwiftUI


struct ContentView: View {
    
    @State var currentDate = Date()
    
    @StateObject private var store = AlarmContainerManager()
    @StateObject var timerClass = TimerClass()
    @StateObject var stopWatchClass = StopWatchClass()
    @State private var analogClock:Bool = false
    @State private var alarm:Bool = false
    @State private var stopWatch:Bool = false
    @State private var timer:Bool = false
    
    init() {    //탭바 색깔 지정
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.white)
        
        
        let itemAppearance = UITabBarItemAppearance(style: .stacked)
        itemAppearance.normal.iconColor = UIColor.lightGray
        appearance.stackedLayoutAppearance = itemAppearance
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        
        NavigationView{
            ZStack(alignment: .top){
                Image("NIGHT").resizable().edgesIgnoringSafeArea(.vertical).edgesIgnoringSafeArea(.horizontal)
                TabView{
                    AnalogClock(analogClock:self.$analogClock)
                        .tabItem {
                            Image(systemName: "clock")
                            Text("시계")
                        }
                    Alarm(alarm:self.$alarm).environment(\.managedObjectContext, store.container.viewContext)
                        .tabItem {
                            Image(systemName: "alarm.fill")
                            Text("알람")
                        }
                    StopWatch(stopWatch:self.$stopWatch).environment(\.managedObjectContext, store.container.viewContext).environmentObject(stopWatchClass)
                        .tabItem {
                            Image(systemName: "stopwatch.fill")
                            Text("스톱워차")
                        }
                    TimerCount(timer:self.$timer).environment(\.managedObjectContext, store.container.viewContext).environmentObject(timerClass)
                        .tabItem {
                            Image(systemName: "timer")
                            Text("타이머")
                        }
                }
                .accentColor(.black)
                   
            }
            
        } .onAppear(){
            self.analogClock = true
            self.alarm = true
            self.stopWatch = true
            self.timer = true
    }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
