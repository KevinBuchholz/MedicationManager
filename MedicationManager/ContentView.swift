//
//  ContentView.swift
//  MedicationManager
//
//  Created by Kevin Buchholz on 9/25/23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        VStack{
            //            Spacer()
            //            Spacer()
            //            Spacer()
            //            Spacer()
            //            Spacer()
            
            ScrollView(.horizontal) {
                
                LazyHStack(alignment: .center, spacing: 15, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                    
                    ForEach(1...10, id: \.self) { count in
                        SingleDayRectangle()
                    }

                    .containerRelativeFrame(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/, count: verticalSizeClass == .regular ? 1 : 3, spacing: 15)
                    .scrollTransition { content, phase in content
                            .opacity(phase .isIdentity ? 1.0 : 0.3)
//                            .scaleEffect(x: phase .isIdentity ? 1.0 : 0.3, y: phase .isIdentity ? 1.0 : 0.8)
//                            .offset(y: phase .isIdentity ? 0 : 50)
                    }
                })
                .scrollTargetLayout()
            }
            .contentMargins(30, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
//            .flipsForRightToLeftLayoutDirection(true)
            .environment(\.layoutDirection, .rightToLeft)
            .scrollIndicators(.hidden)
           
            
            
//            Text("Take a pill")
//                .font(.largeTitle)
//                .padding()
            
            RoundedRectangle(cornerRadius: 15)
                .padding(25)
                .frame(maxWidth: .infinity, maxHeight: 200)
            
                        Spacer()
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
