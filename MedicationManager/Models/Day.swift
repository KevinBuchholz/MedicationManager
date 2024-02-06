//
//  Day.swift
//  MedicationManager
//
//  Created by Kevin Buchholz on 1/31/24.
//

import Foundation

struct Day: Identifiable {
    let id = UUID()
    let date = Date()
    var hasTakenPill : Bool
}
