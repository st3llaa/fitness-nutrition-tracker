//
//  FitnessTrackerAppApp.swift
//  FitnessTrackerApp
//
//  Created by Stella Astbury on 10/17/25.
//

import SwiftUI
import SwiftData
import HealthKit

@main
struct FitnessTrackerAppApp: App {
    // requests permission to read health app data when the app launches
    let healthKitManager = HealthKitManager()

    var body: some Scene {
        WindowGroup { // container for the apps UI's
            ContentView() // first view the user sees
                .onAppear { //runs code when this view appears
                    healthKitManager.requestAuthorization()
                }
        }
        .modelContainer(sharedModelContainer)
    }
    // defines a shared data container for storing app data (using swiftData)
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false) //data exists on disk

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}

