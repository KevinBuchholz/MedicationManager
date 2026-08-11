//
//  PrimaryView.swift
//  MedicationManager
//
//  Created by Kevin Buchholz on 9/25/23.
//

import SwiftUI

struct PrimaryView: View {
    @EnvironmentObject var viewModel : LocalUserViewModel
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        VStack{
            VStack{
                ScrollView(.horizontal) {
                    
                    LazyHStack(alignment: .center, spacing: 10, content: {
                        
                        ForEach(viewModel.days) { day in
                            SingleDayRectangle(day: day)
                        }
                        .containerRelativeFrame(.horizontal, count: verticalSizeClass == .regular ? 1 : 3, spacing: 15)
                        .scrollTransition { content, phase in content
                                .opacity(phase .isIdentity ? 1.0 : 0.3)
                        }
                    })
                    .scrollTargetLayout()
                }
                .contentMargins(30, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                .environment(\.layoutDirection, .rightToLeft)
                .scrollIndicators(.hidden)
            }
            
            TakePillButton()
            
        }
        .onAppear{
            viewModel.loadArrayFromStorage()
            viewModel.makeTodayCount()
        }
    }
}

#Preview {
    PrimaryView()
        .environmentObject(LocalUserViewModel())
}
