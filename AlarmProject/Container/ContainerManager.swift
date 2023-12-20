//
//  ContainerManager.swift
//  AlarmProject
//
//  Created by 유영웅 on 12/20/23.
//

import Foundation
import CoreData

class ContainerManager:ObservableObject{
    let container = NSPersistentContainer(name: "AlarmProject")
   
    init(){
       container.loadPersistentStores{ description, error in
           if let error = error {
               print("Core Data를 불러오는데 실패했습니다. : \(error.localizedDescription)")
           }
       }
    }
    
    func fetchData(){
        
    }
}
