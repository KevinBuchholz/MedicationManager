//
//  LocalUserViewModel.swift
//  MedicationManager
//
//  Created by Kevin Buchholz on 5/19/23.
//
import SwiftUI
import Foundation
import UserNotifications



@MainActor class LocalUserViewModel: ObservableObject {
    
    var passedDays: [Day] = [Day(hasTakenPill: true), Day(hasTakenPill: true), Day(hasTakenPill: false), Day(hasTakenPill: true)]
    
    @Published var days: [Day] = []
    
    var today = Day(hasTakenPill: false)
    
    /// Fills in a Day for every calendar day between the most recent
    /// stored day and today. Safe to call repeatedly — if the most
    /// recent day is already today, it does nothing.
    func makeTodayCount() {
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: .now)

        guard let mostRecent = days.first else {
            days = [Day(date: startOfToday)]
            return
        }

        var cursor = calendar.startOfDay(for: mostRecent.date)
        guard cursor < startOfToday else { return }

        while let next = calendar.date(byAdding: .day, value: 1, to: cursor),
              next <= startOfToday {
            days.insert(Day(date: next), at: 0)
            cursor = next
        }
    }

    /// Marks today's entry as taken, if there is one.
    func takePillToday() {
        guard let index = days.firstIndex(where: {
            Calendar.current.isDateInToday($0.date)
        }) else { return }

        days[index].takePill()
    }
  

    private static let firstLaunchPath = FileManager.documentsDirectory
        .appendingPathComponent("firstLaunchOfApp")
    private static let startDatePath = FileManager.documentsDirectory
        .appendingPathComponent("startDate")

    init() {
        // Decode each value independently so a failure to read one
        // does not discard the other.
        if let data = try? Data(contentsOf: Self.firstLaunchPath),
           let savedFirstLaunch = try? JSONDecoder().decode(Bool.self, from: data) {
            firstLaunchOfApp = savedFirstLaunch
        } else {
            firstLaunchOfApp = true
        }

        if let data = try? Data(contentsOf: Self.startDatePath),
           let savedStartDate = try? JSONDecoder().decode(Date.self, from: data) {
            startDate = savedStartDate
        } else {
            startDate = Date.now
        }
    }
    
    func save() {
        // Not .completeFileProtection: these files must stay readable
        // when the app is launched or woken while the device is locked.
        let writingOptions: Data.WritingOptions = [
            .atomic,
            .completeFileProtectionUntilFirstUserAuthentication
        ]

        do {
            try JSONEncoder().encode(firstLaunchOfApp)
                .write(to: Self.firstLaunchPath, options: writingOptions)
            try JSONEncoder().encode(startDate)
                .write(to: Self.startDatePath, options: writingOptions)
        } catch {
            print("Unable to save data: \(error)")
        }
    }
    
    func saveArrrayToStorage(array: [Date]) {
        UserDefaults.standard.set(array, forKey: "timeLineKey")
    }
    
    func loadArrayFromStorage() {
        localUserTimeLine = UserDefaults.standard.array(forKey: "timeLineKey") as? [Date] ?? []
    }
    

    @Published var firstLaunchOfApp : Bool
    @Published var startDate : Date
    @Published var localUserTimeLine = [Date]()
      
    var userLocale = Locale.autoupdatingCurrent
    var gregorianCalendar = Calendar(identifier: .gregorian)
    let dateComponents = Calendar.current.dateComponents([.weekday], from: Date())



    var authorizedNotifications = false
    let options: UNAuthorizationOptions = [.alert, .sound] // .badge needs to be added back in
    func requestAuthorization(date: Date) {
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Error: \(error)")
                self.authorizedNotifications = false
                
            } else {
                print("Success")
                Task {
                    do {
                        try await self.scheduleCustomNotification(date: date)
                        self.authorizedNotifications = true
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func scheduleCustomNotification(date: Date) async throws {
       
        
        let content = UNMutableNotificationContent()
        content.title = "TAKE YOUR PILLS"
        content.subtitle = "NOWWWWWWW"
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second, .timeZone], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        try await UNUserNotificationCenter.current().add(request)
        

    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func clearBadge() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
   
}
