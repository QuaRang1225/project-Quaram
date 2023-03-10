//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI

struct StopWatch:View{
    
    @Binding var stopWatch  : Bool
        
    init(stopWatch:Binding<Bool> = .constant(false)){
        _stopWatch = stopWatch
    }
    var body: some View{
        ZStack{
            Image("NIGHT").resizable().edgesIgnoringSafeArea(.vertical).edgesIgnoringSafeArea(.horizontal)
            StopWatchWindow()
        }
        
    }
}
struct StopWatch_Previews: PreviewProvider {

    static var previews: some View {
        StopWatch().environmentObject(StopWatchClass())
    }
}
