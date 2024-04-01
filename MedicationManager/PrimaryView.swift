//
//  ContentView.swift
//  MedicationManager
//
//  Created by Kevin Buchholz on 9/25/23.
//

import SwiftUI

struct PrimaryView: View {
    @EnvironmentObject var viewModel : LocalUserViewModel
    @Environment (\.verticalSizeClass) var verticalSizeClass
//    let date = Date.now
    
    var body: some View {
        VStack{
            VStack{
                ScrollView(.horizontal) {
                    
                    LazyHStack(alignment: .center, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                        
                        ForEach(viewModel.dayArray, id: \.self) { count in
                            count
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
            print(viewModel.localUserTimeLine)
        }
    }
}

#Preview {
    PrimaryView()
        .environmentObject(LocalUserViewModel())
}
