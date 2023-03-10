//
//  StopWatchClass.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/28.
//

import Foundation
import SwiftUI

enum mode{
    case run
    case stop
    case pause
}
class StopWatchClass:ObservableObject{
    
    @Published var timeElapsed = 0.00
    @Published var stopMode:mode = .stop
    
    var timer = Timer()
    func start(){
        stopMode = .run
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ timer in
            self.timeElapsed += 0.01
        }
    }
    
    func stop(){
        timer.invalidate()
        timeElapsed = 0
        stopMode = .stop
    }
    func pause(){
        timer.invalidate()
        stopMode = .pause
    }
    
}
