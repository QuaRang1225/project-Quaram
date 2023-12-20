//
//  StopWatchWindow.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/28.
//

import Foundation
import SwiftUI


struct StopWatchWindow:View{
    
    @Environment(\.managedObjectContext) var mac
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WatchEntity.stopwatchList, ascending: true)]) var stopList: FetchedResults<WatchEntity>
    
    @EnvironmentObject var stopWatchClass : StopWatchClass
    @State private var animate = 0.0
    @State var textColor = Color.white

    var body: some View{
        VStack{
            Spacer().frame(height:50)
            HStack{
                Spacer().frame(width: 150)
                Text(String(format: "%.2f", stopWatchClass.timeElapsed))
                .fixedSize(horizontal: true, vertical: false)
                Spacer()
            }
            .kerning(10).font(.title).foregroundColor(textColor).fontWeight(.bold).padding()
            Spacer().frame(height:50)
            switch stopWatchClass.stopMode {
            case .stop:
                HStack{
                    Button(action: {
                        timeStore()
                    }){
                        StopWatchButton(image: "stopwatch.fill")
                    }
                    Spacer().frame(width: 30)
                    Button(action: {
                        stopWatchClass.start()
                    }){
                        StopWatchButton(image: "play.fill")
                    }
                    Spacer().frame(width: 30)
                    Button(action: {
                        stopWatchClass.stop()
                    }){
                        StopWatchButton(image: "stop.fill")
                    }
                }
            case .run:
                HStack{
                    Button(action: {
                        timeStore()
                        //print(time.stopwatchList)
                    }){
                        StopWatchButton(image: "stopwatch.fill")
                    }
                    Spacer().frame(width: 30)
                    Button(action: {
                        stopWatchClass.pause()
                        //animationAmount.toggle()
                    }){
                        StopWatchButton(image: "pause.fill")
                    }
                    Spacer().frame(width: 30)
                    Button(action: {
                        stopWatchClass.stop()
                    }){
                        StopWatchButton(image: "stop.fill")
                    }
                }
                
            case .pause:
                HStack{
                    Button(action: {
                        timeStore()
                    }){
                        StopWatchButton(image: "stopwatch.fill")
                    }
                    Spacer().frame(width: 30)
                    Button(action: {
                        stopWatchClass.start()
//                        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)){
//                            animationAmount.toggle()
//                        }
                    }){
                        StopWatchButton(image: "play.fill")
                    }
                    Spacer().frame(width: 30)
                    Button(action: {
                        stopWatchClass.stop()
                    }){
                        StopWatchButton(image: "stop.fill")
                    }
                }
            }
            
            List{
//                ForEach(stopList){ lap in
//                    Text("\(lap.stopwatchList ?? "")초")
//                }.onDelete(perform: deleteList)
//                    .listRowBackground(Color.clear)
            }.listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                .padding()
                .foregroundColor(.white)

            
        }
        
    }
    func deleteList(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
//        let times = stopList[index]
//        mac.delete(times)
        try? mac.save()
    }
    func timeStore(){
//        let time = WatchEntity(context:mac)
//        time.stopwatchList = String(format: "%00.2f", stopWatchClass.timeElapsed)
        try? mac.save()
    }
}
struct StopWatchWindow_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchWindow().environmentObject(StopWatchClass())
    }
}
