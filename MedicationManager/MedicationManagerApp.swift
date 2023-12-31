//
//  MedicationManagerApp.swift
//  MedicationManager
//
//  Created by Kevin Buchholz on 9/25/23.
//

import SwiftUI

@main
struct MedicationManagerApp: App {
    @StateObject var viewModel = LocalUserViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LocalUserViewModel())
        }
    }
}
