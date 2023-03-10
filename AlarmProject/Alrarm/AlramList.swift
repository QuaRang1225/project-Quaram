//
//  AlramList.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/16.
//

import Foundation
import SwiftUI

struct AlarmList:View{
    var time:String
    var content:String

    var body: some View{

            HStack{
                Image(systemName: "alarm.fill")
                Text(content)
                Spacer()
                Text(time).font(.system(size: 25))
            }.foregroundColor(.white)
            
        
    }
}
struct AlarmList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            AlarmList(time: "d",content: "안녕")
        }
        
    }
}
