//
//  InitiialInterruptionTime.swift
//  recreate
//
//  Created by Kevin Buchholz on 5/19/23.
//

import SwiftUI


struct OnboardingView: View {
    
    @EnvironmentObject var viewModel : LocalUserViewModel
    @State private var setInterruptor : Date = Date()
    @State var timeLine = [Date]()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = .autoupdatingCurrent
        formatter.timeStyle = .short
        formatter.timeZone = .autoupdatingCurrent
        return formatter
    }()
    
    var body: some View {
        NavigationStack{
            VStack{

                Text("What time do you take your medication?")
                    .padding(5)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .frame(width: 350)
                     
                Text("Set a time for a daily reminder to take  your medicine.")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .frame(width: 350)
                
                DatePicker("Choose at one time:", selection: $setInterruptor, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                
                Button("Set Time") {
                    if viewModel.authorizedNotifications == false {
                        viewModel.requestAuthorization(date: setInterruptor)
                        viewModel.localUserTimeLine.append(setInterruptor)
                        viewModel.saveArrrayToStorage(array: viewModel.localUserTimeLine)
                        
                        print("\(viewModel.localUserTimeLine)")
                        
                    }else {

                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .buttonBorderShape(.roundedRectangle(radius: 10))
                .font(.title)
                .padding()

                
                NavigationLink("Continue", destination: ContentView())
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, height: 50, alignment: .center)
                    .font(.title)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .containerShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    .simultaneousGesture(TapGesture().onEnded{

                        viewModel.firstLaunchOfApp.toggle()
                        viewModel.save()

                    })
                    .padding()
            }
        }
        .navigationBarTitle("")
        .toolbar(.hidden)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(LocalUserViewModel())
    }
}
