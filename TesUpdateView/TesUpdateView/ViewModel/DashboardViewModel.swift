//
//  DashboardViewModel.swift
//  TesUpdateView
//
//  Created by heri hermawan on 04/10/22.
//

import SwiftUI
import CoreData

class DashboardViewModel: ObservableObject {
    @Published var ecg = ""
    @Published var activity = ""
    
    @Published var isNewData = false
    
    @Published var updateItem : Item!
    
    func addItem(viewContext: NSManagedObjectContext) {
        withAnimation {
            if updateItem != nil {
                updateItem.ecg = ecg
                updateItem.activity = activity
                
                try! viewContext.save()
                updateItem = nil
                return
            }
            
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.ecg = ecg
            newItem.activity = activity

            do {
                try viewContext.save()
//                isNewData.toggle()
                ecg = ""
                activity = ""
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func editItem(item: Item?){
        updateItem = item
        guard let ecgTemp = item?.ecg else { return }
        ecg = ecgTemp
        guard let activityTemp = item?.activity else { return }
        activity = activityTemp
    }
}
