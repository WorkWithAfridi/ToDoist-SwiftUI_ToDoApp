//
//  iToDoistApp.swift
//  iToDoist
//
//  Created by Khondakar Afridi on 24/5/23.
//

import SwiftUI

@main
struct iToDoistApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
