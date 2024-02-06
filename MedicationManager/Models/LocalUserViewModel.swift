//
//  PrimaryViewModel.swift
//  recreate
//
//  Created by Kevin Buchholz on 5/19/23.
//
import SwiftUI
import Foundation

// The PrimaryView needs a navigation to UserPreferences - probably doesn't need to be here.
// The PrimaryView needs a progress visualization.
// The PrimaryView needs to populate with prompt for the user to "do an activity" instead of looking at social media.

@MainActor class LocalUserViewModel: ObservableObject {
    
    var passedDays : [Day] = [Day(hasTakenPill: true), Day(hasTakenPill: true), Day(hasTakenPill: false), Day(hasTakenPill: true)]
    
    var dayArray : [Day] = [Day(hasTakenPill: true)]
    
    var today = Day(hasTakenPill: false)
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("firstLaunchOfApp")
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            firstLaunchOfApp = try JSONDecoder().decode(Bool.self, from: data)
            
        } catch {
            firstLaunchOfApp = true
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(firstLaunchOfApp)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
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
    @Published var localUserTimeLine = [Date]() 
//    @Published var hasTakenPill = false
//    @State var hasTakenPill = false
    
  
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
