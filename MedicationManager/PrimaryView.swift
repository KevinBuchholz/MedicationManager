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
    @State var hasTakenPill = false
    
    var body: some View {
        VStack{
            VStack{
                ScrollView(.horizontal) {
                    
                    LazyHStack(alignment: .center, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                        
                        ForEach(1...10, id: \.self) { count in
                            SingleDayRectangle()
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

            VStack {
                
                Button{
                    hasTakenPill.toggle()
                    print("\(viewModel.localUserTimeLine)")
                } label: {
                    Text("Take your Pill")
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .bottomTrailing)
                        .font(.largeTitle)
                        .fontWeight(.ultraLight)
                        .padding()
                        .foregroundColor(.black)
                        .background{
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.green)
                                .opacity(0.2)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.black, lineWidth: 1)
                                .opacity(0.3))
                        .padding(30)
                }
            }
//            .onAppear{
//                viewModel.loadArrayFromStorage()
//                print(viewModel.localUserTimeLine)
//            }
            
        }
    }
}

#Preview {
    PrimaryView()
}
