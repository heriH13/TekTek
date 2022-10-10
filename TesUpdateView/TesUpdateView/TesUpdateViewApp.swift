//
//  TesUpdateViewApp.swift
//  TesUpdateView
//
//  Created by heri hermawan on 04/10/22.
//

import SwiftUI

@main
struct TesUpdateViewApp: App {
    let persistenceController = PersistenceController.shared
//    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
//            ContentView()
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
