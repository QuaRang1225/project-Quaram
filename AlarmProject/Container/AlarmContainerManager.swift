//
//  ContainerManager.swift
//  AlarmProject
//
//  Created by 유영웅 on 12/20/23.
//

import Foundation
import CoreData

class AlarmContainerManager: ObservableObject {
    
    @Published var alarmList: [AlarmEntity] = []
    
    // NSPersistentContainer를 생성하고 초기화하는 클래스의 생성자
    let container = NSPersistentContainer(name: "AlarmProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data를 불러오는데 실패했습니다. : \(error.localizedDescription)")
            }
        }
        // 초기화 시 데이터를 불러와 알림 목록에 할당
        fetchData()
    }
    
    // CoreData에서 데이터를 불러와 알림 목록에 할당하는 메서드
    private func fetchData() {
        let request = NSFetchRequest<AlarmEntity>(entityName: "AlarmEntity")
        do {
            alarmList = try container.viewContext.fetch(request)
        } catch let error {
            print("fetch 실패 \(error.localizedDescription)")
        }
    }
    
    // CoreData에 데이터를 저장하고 데이터를 다시 불러오는 메서드
    private func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        } catch let error {
            print("save 실패 \(error.localizedDescription)")
        }
    }
    func deleteBooks(at offsets: IndexSet){
        guard let index = offsets.first else {return}
        let entity = alarmList[index]
        AlertAlarm.caancelAlarm(id: entity.id ?? "")  //알람 취소
        container.viewContext.delete(entity)
        saveData()
    }
    
    // 알림 데이터를 추가하는 메서드
    func addData(alarm: AlarmData) {
        // 새로운 AlarmEntity 인스턴스를 생성하여 CoreData에 추가
        let newAlarm = AlarmEntity(context: container.viewContext)
        // 전달된 AlarmData의 속성을 새로운 AlarmEntity에 할당
        newAlarm.id = alarm.id
        newAlarm.title = alarm.title
        newAlarm.time = alarm.time
        saveData()
    }
}
