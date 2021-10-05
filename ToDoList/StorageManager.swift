//
//  StorageManager.swift
//  ToDoList
//
//  Created by Олег Федоров on 05.10.2021.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
        
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    func getContext() -> NSManagedObjectContext {
        let context = persistentContainer.viewContext
        return context
    }
    
    func getTask() -> Task {
        let task = Task(context: persistentContainer.viewContext)
        return task
    }
    
    func fetchTaskList() -> [Task] {
        let request = Task.fetchRequest()
        var fetchedTaskList: [Task] = []
        
        do {
            fetchedTaskList = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
        
        return fetchedTaskList
    }
    
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
    }
}
