//
//  Day.swift
//  MedicationManager
//
//  Created by Kevin Buchholz on 1/31/24.
//

import Foundation

struct Day: Identifiable, Hashable {
    let id = UUID()
    var date: Date
    var hasTakenPill: Bool

    init(date: Date = .now, hasTakenPill: Bool = false) {
        self.date = date
        self.hasTakenPill = hasTakenPill
    }

    mutating func takePill() {
        hasTakenPill = true
    }
}
