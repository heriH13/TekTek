//
//  Dashboard.swift
//  TesUpdateView
//
//  Created by heri hermawan on 04/10/22.
//

import SwiftUI
import CoreData

struct Dashboard: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var dashboardViewModel = DashboardViewModel()
    @State var isPresented = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        predicate: NSPredicate(format: "activity == %@", ""),
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink {
//                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    dashboardViewModel.editItem(item: item)
                    NewData(dashboardData: dashboardViewModel, item: item, isPresented: $isPresented)
                } label: {
//                    Text(item.timestamp!, formatter: itemFormatter)
                    Text(item.ecg ?? "No ECG")
                    Text(item.activity ?? "Nil")
                }
            } //ForEach
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: {isPresented.toggle()}) {
                    Label("Add Item", systemImage: "plus")
                }
                .sheet(isPresented: $isPresented) {
                    NewData(dashboardData: dashboardViewModel, item: nil, isPresented: $isPresented)
                }
//                Button(action: {dashboardViewModel.isNewData.toggle()}) {
//                    Label("Add Item", systemImage: "plus")
//                }
//                .sheet(isPresented: $dashboardViewModel.isNewData) {
//                    NewData(dashboardData: dashboardViewModel)
//                }
//                Button(action: dashboardViewModel.addItem(viewContext: viewContext)) {
//                    Label("Add Item", systemImage: "plus")
//                }
            }
        }
        .navigationTitle("Dashboard")
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
