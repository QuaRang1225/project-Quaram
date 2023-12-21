//
//  ContentView.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import SwiftUI


struct ContentView: View {
    
    
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
                    AnalogClock()
                        .tabItem {
                            Image(systemName: "clock")
                            Text("시계")
                        }
                    Alarm()
                        .tabItem {
                            Image(systemName: "alarm.fill")
                            Text("알람")
                        }
                    StopWatch()
                        .tabItem {
                            Image(systemName: "stopwatch.fill")
                            Text("스톱워차")
                        }
                    TimerCount()
                        .tabItem {
                            Image(systemName: "timer")
                            Text("타이머")
                        }
                }
                .accentColor(.black)
                   
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
