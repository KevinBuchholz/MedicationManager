//
//  ContentView.swift
//  recreate
//
//  Created by Kevin Buchholz on 5/19/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: LocalUserViewModel

    var body: some View {
        Group{
            if viewModel.firstLaunchOfApp == true {
                OnboardingView()
            }else {
                PrimaryView()
            }
        }
       
        // if user hasn't opened app before go to initial view (onboarding)
        // If user has opened app before go to primary view
        
    }
}

