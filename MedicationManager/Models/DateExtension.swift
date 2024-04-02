//
//  DateExtension.swift
//  MedicationManager
//
//  Created by Kevin Buchholz on 4/2/24.
//

import Foundation

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }
    
    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}
