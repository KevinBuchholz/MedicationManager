//
//  SingleDayRectangle.swift
//  MedicationManager
//
//  Created by Kevin Buchholz on 10/24/23.
//

import SwiftUI

struct SingleDayRectangle: View {
    let day: Day

    private var itemColor: Color {
        day.hasTakenPill ? .green : .pink
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .aspectRatio(1, contentMode: .fit)
            .foregroundStyle(itemColor)
            .opacity(0.1)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.secondary, lineWidth: 1)
                    .opacity(0.4))
            .overlay(
                Text(day.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.largeTitle)
                    .fontWeight(.ultraLight)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topTrailing)
                    .padding())
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(day.date.formatted(date: .complete, time: .omitted))
            .accessibilityValue(day.hasTakenPill ? "Pill taken" : "Pill not taken")
    }
}

#Preview {
    SingleDayRectangle(day: Day(hasTakenPill: false))
}
