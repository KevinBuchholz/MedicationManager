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
    @State var hasTakenPill = false
    
    var body: some View {
        VStack{
            VStack{
                ScrollView(.horizontal) {
                    
                    LazyHStack(alignment: .center, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                        
                        ForEach(1...10, id: \.self) { count in
                            SingleDayRectangle(hasTakenPill: PrimaryView().$hasTakenPill)
                        }
                        
                        .containerRelativeFrame(.horizontal, count: verticalSizeClass == .regular ? 1 : 3, spacing: 15)
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
                .environment(\.layoutDirection, .rightToLeft)
                .scrollIndicators(.hidden)
            }
            VStack {
                
                Button{
                    hasTakenPill.toggle()
                    print("\(viewModel.localUserTimeLine)")
                } label: {
                    Text("Take your Pill")
//                        .frame(maxWidth: .infinity, maxHeight: 100)
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
                //            .contentShape(RoundedRectangle(cornerRadius: 10))
                
                //            RoundedRectangle(cornerRadius: 15)
                //                .padding(25)
                //                .frame(maxWidth: .infinity, maxHeight: 200)
//                        Spacer()
              
            }
            .onAppear{
                viewModel.loadArrayFromStorage()
                print(viewModel.localUserTimeLine)
            }
            
        }
    }
}
//struct PrimaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        PrimaryView()
//            .environmentObject(LocalUserViewModel())
//    }
//}

#Preview {
    PrimaryView()
}
