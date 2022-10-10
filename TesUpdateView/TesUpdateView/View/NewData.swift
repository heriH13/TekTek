//
//  NewData.swift
//  TesUpdateView
//
//  Created by heri hermawan on 04/10/22.
//

import SwiftUI

struct NewData: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var dashboardData : DashboardViewModel
    var item : Item?
    @Binding var isPresented: Bool
    
    var body: some View {

        VStack {
            HStack {
                Text("ECG")
                TextField("ECG", text: $dashboardData.ecg)
            }
            
            HStack{
                Text("Activity")
                TextField("Activity", text: $dashboardData.activity)
            }
            
            Button("SAVE"){
                dashboardData.addItem(viewContext: viewContext)
                isPresented.toggle()
            }
        }
        .onAppear{
            dashboardData.editItem(item: item)
        }
        .navigationTitle("Add New Data")
    }
}

//struct NewData2: View{
//    @State var isPresented = true
//    var body : some View{
//        NewData(dashboardData: DashboardViewModel(), item: <#Item#>, isPresented: $isPresented)
//    }
//}
//
//struct NewData_Previews: PreviewProvider {
//    @State var isPresented = true
//    static var previews: some View {
//        NewData2()
//    }
//}
