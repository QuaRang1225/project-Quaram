//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI

struct StopWatch:View{

    @StateObject var stopWatchClass = StopWatchClass()
    @StateObject var stopwatchManager = StopWatchContainerManager()
    
    var timeStore:StopWatchData{
        let timeStamp =  String(format: "%00.2f", stopWatchClass.timeElapsed)
        return StopWatchData(time: timeStamp)
    }
    
    var body: some View{
        VStack{
            Spacer().frame(height:50)
            HStack{
                Spacer().frame(width: UIScreen.main.bounds.width/3)
                Text(String(format: "%.2f", stopWatchClass.timeElapsed))
                    .fixedSize(horizontal: true, vertical: false)
                Spacer()
            }
            .kerning(10)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
            Spacer().frame(height:50)
            HStack{
                Group{
                    buttonType(image: "stopwatch.fill"){ stopwatchManager.addData(stopWatch: timeStore)
                    }
                    switch stopWatchClass.stopMode {
                    case .stop,.pause:
                        buttonType(image: "play.fill"){ stopWatchClass.start() }
                    case .run:
                        buttonType(image: "pause.fill"){ stopWatchClass.pause() }
                    }
                    buttonType(image: "stop.fill"){ stopWatchClass.stop() }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal,50)
            List{
                ForEach(stopwatchManager.stopWatchList){ time in
                    Text("\(time.time ?? "")초")
                }
                .onDelete(perform:stopwatchManager.deleteBooks)                .listRowBackground(Color.clear)
            }.listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                .padding()
        }
        .foregroundColor(.white)
        .background(Image("NIGHT").resizable().ignoresSafeArea())
    }
    func buttonType(image:String,action:@escaping ()->())-> some View{
        Button(action: action, label: {
            StopWatchButton(image: image)
        })
    }
}
struct StopWatch_Previews: PreviewProvider {

    static var previews: some View {
        StopWatch().environmentObject(StopWatchClass())
    }
}
