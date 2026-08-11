//
//  PrimaryViewModel.swift
//  recreate
//
//  Created by Kevin Buchholz on 5/19/23.
//
import SwiftUI
import Foundation



@MainActor class LocalUserViewModel: ObservableObject {
    
    var passedDays: [Day] = [Day(hasTakenPill: true), Day(hasTakenPill: true), Day(hasTakenPill: false), Day(hasTakenPill: true)]
    
    @Published var dayArray: [SingleDayRectangle] = []
    
    var today = Day(hasTakenPill: false)
    
    func makeTodayCount() {
        let newDay = SingleDayRectangle()
        let dayDurationInSeconds: TimeInterval = 60*60*24
        
        if dayArray.isEmpty {
            dayArray.insert(newDay, at: 0)
        } else if
            Date.now > dayArray[0].date
        {
            let lastDate = dayArray[0].date
            
            for date in stride(from: lastDate, to: Date.now, by: dayDurationInSeconds) {
                dayArray.insert(newDay, at: 0)
            }
            
        }
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
        do {
            try JSONEncoder().encode(firstLaunchOfApp)
                .write(to: Self.firstLaunchPath, options: [.atomic, .completeFileProtection])
            try JSONEncoder().encode(startDate)
                .write(to: Self.startDatePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data: \(error)")
        }
    }
    
    func saveArrrayToStorage(array: [Date]) {
        UserDefaults.standard.set(array, forKey: "timeLineKey")
    }
    
    func loadArrayFromStorage() -> [Date]? {
        print("Loading")
        return UserDefaults.standard.array(forKey: "timeLineKey") as? [Date]
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
    
    //    func scheduleNotification(date: Date){
    //
    //        let content = UNMutableNotificationContent()
    //        content.title = "This is the Interruptor Title."
    //        content.subtitle = "This is the Interruptor Subtitle."
    //        content.sound = .default
    //        content.badge = 1
    //
    //
    //        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .timeZone], from: date)
    //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    //
    //
    //        let request = UNNotificationRequest(
    //            identifier: UUID().uuidString,
    //            content: content,
    //            trigger: trigger)
    //        UNUserNotificationCenter.current().add(request)
    //
    //    }
    func drawToday(date: Date) {
//        SingleDayRectangle(hasTakenPill: false)
    }
    
    func scheduleCustomNotification(date: Date) async throws {
       
        
        let content = UNMutableNotificationContent()
        content.title = "TAKE YOUR PILLS"
        content.subtitle = "NOWWWWWWW"
        content.sound = .default
//        content.badge = 1
        
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
