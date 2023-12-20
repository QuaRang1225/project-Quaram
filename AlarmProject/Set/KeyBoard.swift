//
//  KeyBoard.swift
//  AlarmProject
//
//  Created by 유영웅 on 12/20/23.
//

import Foundation
import UIKit

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }   //키보드 dismissing
}
