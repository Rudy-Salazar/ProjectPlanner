//
//  reminderView.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 2/16/21.
//

import SwiftUI
import NotificationCenter

struct ReminderView: View {
    @State var reminderData: Date
    
    var body: some View {
        VStack {
            DatePicker("Set reminder",
                       selection: $reminderData, displayedComponents: [.date, .hourAndMinute])
            Spacer()
                .frame(height: 50)
            Button(action: {
                scheduleNotification()
            }) {
                Text("Save")
            }
            .padding()
            .background(Color.secondarySystemGroupedBackground)
            .cornerRadius(10)
        }
        .padding()
    }
    
    func scheduleNotification() -> Void {
        let content = UNMutableNotificationContent()
        content.title = "Your title"
        content.body = "Your body"
        
        var reminderDate = reminderData
        
        if reminderDate < Date() {
            if let addedValue = Calendar.current.date(byAdding: .day, value: 1, to: reminderDate) {
                reminderDate = addedValue
            }
        }
        
        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        
        let request = UNNotificationRequest(identifier: "alertNotificationUnique", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("\(error)")
            }
        }
    }
    
    func requestPush() -> Void {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success , error in
            if success {
                print("All set")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
        
}

struct reminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView(reminderData: Date())
    }
}
