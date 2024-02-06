//
//  SingleDayRectangle.swift
//  PillPopper
//
//  Created by Kevin Buchholz on 10/24/23.
//

import SwiftUI

//let date = Date()
//var userLocale = Locale.autoupdatingCurrent
//var gregorianCalendar = Calendar(identifier: .gregorian)
//let dateComponents = Calendar.current.dateComponents([.weekday], from: date)

struct SingleDayRectangle: Identifiable, View {
  
    @EnvironmentObject var viewModel : LocalUserViewModel
    let id = UUID()
    let date = Date.now
    var userLocale = Locale.autoupdatingCurrent
    var gregorianCalendar = Calendar(identifier: .gregorian)
    let dateComponents = Calendar.current.dateComponents([.weekday], from: Date())
    
    
    @Binding var hasTakenPill : Bool
    
    var body: some View {
//        let dayOfWeek = dateComponents.weekday
        
            RoundedRectangle(cornerRadius: 15)
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(hasTakenPill ? Color.green : Color.pink)
                .opacity(0.1)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black, lineWidth: 1)
                        .opacity(0.2))
                .overlay(Text(Date.now.formatted(date: .abbreviated, time: .omitted))
                
                    .font(.largeTitle)
                    .fontWeight(.ultraLight)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topTrailing)
                        .padding())
    }
}

#Preview {
    SingleDayRectangle(hasTakenPill: PrimaryView().$hasTakenPill)
        .environmentObject(LocalUserViewModel())
}
