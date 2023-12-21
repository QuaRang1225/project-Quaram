//
//  Timer.swift
//  AlarmProject
//
//  Created by 유영웅 on 12/20/23.
//

import Foundation

enum TimerMode{
    case run
    case stop
    case pause
    
    var image:String{
        switch self{
        case .stop,.pause:
            return "play.fill"
        case .run:
            return "pause.fill"
        }
    }
}
