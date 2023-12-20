//
//  ContainerManager.swift
//  AlarmProject
//
//  Created by 유영웅 on 12/20/23.
//

import Foundation
import CoreData

class AlarmContainerManager:ObservableObject{
    @Published var alarmList:[AlarmEntity] = []
    let container = NSPersistentContainer(name: "AlarmProject")
   
    init(){
       container.loadPersistentStores{ description, error in
           if let error = error {
               print("Core Data를 불러오는데 실패했습니다. : \(error.localizedDescription)")
           }
       }
        fetchData()
    }
    
    private func fetchData(){   //새로고침
        let request = NSFetchRequest<AlarmEntity>(entityName: "AlarmEntity")
        do {
            alarmList = try container.viewContext.fetch(request)
        } catch let error {
            print("fetch 실패 \(error.localizedDescription)")
        }
    }
    
    private func saveData(){    //저장
        do {
            try container.viewContext.save()
            fetchData()
        } catch let error {
            print("save 실패 \(error.localizedDescription)")
        }
    }
    
    func addData(alarm:AlarmData){  //추가
        let newAlarm = AlarmEntity(context: container.viewContext)
        newAlarm.id = alarm.id
        newAlarm.title = alarm.title
        newAlarm.time = alarm.time
        saveData()
    }
    
}
