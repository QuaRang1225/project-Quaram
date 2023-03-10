//
//  worldTime.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/15.
//

import Foundation
import SwiftUI

struct TimerCount:View{
    
    @Binding var timer  : Bool
    
    init(timer:Binding<Bool> = .constant(false)){
        _timer = timer
    }
    var body: some View{
        ZStack(alignment: .topLeading){
                
                TimerWindow().frame(maxHeight: .infinity,alignment: .center)
           
        }.background{
            Image("NIGHT")
                .resizable().edgesIgnoringSafeArea(.vertical).edgesIgnoringSafeArea(.horizontal)
        }.navigationBarBackButtonHidden(true)
        
    }
}
struct TimerCount_Previews: PreviewProvider {
    static var previews: some View {
        TimerCount().environmentObject(TimerClass())
    }
}
