//
//  CalendarView.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 4/28/21.
//
import SwiftUI
import UIKit
import CoreData
import FSCalendar

struct CalView: View {
    static let tag: String? = "Calendar"
    @State var selectedDate: Date = Date()
    @State private var dueDate = Date()
    let dateFormatter = DateFormatter()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Project.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Project.dueDate, ascending: true)]
    ) var projects: FetchedResults<Project>

    var dateFormatter2: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }

    var body: some View {
//        List(projects) { project in
//            Text("\(project.dueDate ?? Date(), formatter: self.dateFormatter2)")
//        }
        VStack {
            CalendarRepresentable(selectedDate: $selectedDate)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                )
                .frame(height: 350)
                .padding()
            
//            Text("\(projects.endIndex)")
        }
    } 
}

struct CalendarRepresentable: UIViewRepresentable {
    
    @State private var dueDate = Date()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Project.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Project.dueDate, ascending: true)]
    ) var projects: FetchedResults<Project>
    
    typealias UIViewType = FSCalendar
    @Binding var selectedDate: Date
    var calendar = FSCalendar()
    
    func updateUIView(_ uiView: FSCalendar, context: Context) { }
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        return calendar
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        @State private var dueDate = Date()
        
        @Environment(\.managedObjectContext) var managedObjectContext
        @FetchRequest(entity: Project.entity(),
                      sortDescriptors: [NSSortDescriptor(keyPath: \Project.dueDate, ascending: true)]
        ) var projects: FetchedResults<Project>
        
        var parent:  CalendarRepresentable
        var datesWithEvent = ["05-29-2021", "05-30-2021"]
        
        var body: some View {
            Text("K")
//            List(projects) { project in
//                Text("\(project.dueDate ?? Date(), formatter: self.dateFormatter2)")
//            }
           
        }

//        var datesWithEvent = ["\(\Project.dueDate)"]
//        lazy var datesWithEvent = ["\(projects)"]

//        fileprivate lazy var dateFormatter2: DateFormatter = {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "MM-dd-yyyy"
//            return formatter
//        }()
        
        fileprivate lazy var dateFormatter2: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            formatter.timeStyle = .full
            return formatter
        }()

        init(_ parent: CalendarRepresentable) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            let dateString = self.dateFormatter2.string(from: date)
            
            if self.datesWithEvent.contains(dateString) {
                return 1
            }
            
            return 0
        }
        
//        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//            formatter.dateFormat = "dd-MM-yyyy"
//                guard let eventDate = formatter.date(from: "28-05-2021") else { return 0 }
//            if date.compare(eventDate) == .orderedSame {
//                return 1
//            }
//            return 2
//        }
        
    }
    
}

