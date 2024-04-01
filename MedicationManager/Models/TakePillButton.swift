//
//  TakePillButton.swift
//  MedicationManager
//
//  Created by Kevin Buchholz on 4/1/24.
//

import SwiftUI

struct TakePillButton: View {
    @EnvironmentObject var viewModel: LocalUserViewModel
    var body: some View {
        Button{
            viewModel.dayArray[0].hasTakenPill = true
            
            print(viewModel.dayArray[0])
            print(viewModel.dayArray)
            
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
}

#Preview {
    TakePillButton()
}
