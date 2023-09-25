//
//  DayView.swift
//  MedicationManager
//
//  Created by Kevin Buchholz on 9/25/23.
//

import SwiftUI

struct DayView: View {
    var body: some View {
        ZStack {
            Text("Monday")
                .font(.largeTitle)
                .fontWeight(.ultraLight)
//                .offset(x: -100, y: -250)
                .frame(minWidth: 200, idealWidth: 300, maxWidth: 600, minHeight: 200, idealHeight: 300, maxHeight: 600, alignment: .topLeading)
                .padding(.top)
                .padding(20)
            
            RoundedRectangle(cornerRadius: 15)
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 200, idealWidth: 300, maxWidth: 600, minHeight: 200, idealHeight: 300, maxHeight: 600, alignment: .top)
                .foregroundColor(.pink)
                .opacity(0.1)
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
    }
}
