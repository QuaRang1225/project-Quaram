//
//  FormatterClass.swift
//  AlarmProject
//
//  Created by 유영웅 on 2022/07/27.
//
import SwiftUI

class FormatterClass{
    
    static let shared = FormatterClass()
    
    var timerFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH':'mm':'ss"
        return formatter
        
    }
    var countFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH'시간'mm'분'ss'초'"
        return formatter
        
    }
    
    
    var yearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'년' MM'월' dd'일' a HH':'mm':'ss"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        return formatter
        
    }
    var yearsettingFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy'년' MM'월' dd'일' a HH':'mm':'00"
        return formatter
        
    }
    var HourminuteForMatter:DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "hh':'mm"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        return formatter
    }
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh':'mm':'ss"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        return formatter
    }
    var meridiemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        return formatter
    }
    
    var dateFormatter:DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'/'MM'/'dd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        return formatter
    }
    
    
    // 숫자로 표현된 요일을 문자열로 변환하는 함수
    func weekdayStringFromInt() -> String {
        let currentDate = Date()
        let dayOfWeek = Calendar.current.component(.weekday, from: currentDate)
        
        switch dayOfWeek {
        case 1:
            return "일"
        case 2:
            return "월"
        case 3:
            return "화"
        case 4:
            return "수"
        case 5:
            return "목"
        case 6:
            return "금"
        case 7:
            return "토"
        default:
            return ""
        }
    }
}
