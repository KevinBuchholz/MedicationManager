//
//  ContentView.swift
//  MedicationManager
//
//  Created by Kevin Buchholz on 9/25/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 10) {
                    ForEach(1...100, id: \.self) {_ in
                        DayView()
                    }
                }
            }
            .frame(maxWidth: 1000)
            .edgesIgnoringSafeArea(.horizontal)
          
            
            VStack {
                RoundedRectangle(cornerRadius: 15)
                RoundedRectangle(cornerRadius: 15)
                RoundedRectangle(cornerRadius: 15)
            }
            .padding(30)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
