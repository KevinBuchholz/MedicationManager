//
//  SingleDayRectangle.swift
//  PillPopper
//
//  Created by Kevin Buchholz on 10/24/23.
//

import SwiftUI

struct SingleDayRectangle: View {
    var body: some View {
        
            RoundedRectangle(cornerRadius: 15)
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(.pink)
                .opacity(0.2)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black, lineWidth: 1)
                        .opacity(0.2))
                .overlay(Text("Monday 12")
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
    SingleDayRectangle()
}
