//
//  AddProjectView.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 3/16/21.
//

import SwiftUI
import NotificationCenter

struct AddProjectView: View {
    let project: Project

    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode

    @State private var title: String
    @State private var detail: String
    @State private var color: String
    @State private var dueDate: Date
    @State private var reminderDate: Date
    @State private var showingDeleteConfirm = false

    let colorColumns = [
        GridItem(.adaptive(minimum: 44))
    ]

    init(project: Project) {
        self.project = project

        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
        _dueDate = State(wrappedValue: project.projectDueDate)
        _reminderDate = State(wrappedValue: project.projectReminderDate)
    }

    var body: some View {
        ZStack {
        
        Form {
            Section(header: Text("Basic settings")) {
                TextField("Project name", text: $title.onChange(update))
                
                TextField("Description of this project", text: $detail.onChange(update))
                
                DatePicker("Enter due date", selection: $dueDate.onChange(update), in: Date()..., displayedComponents: .date)
            
                VStack {
                    DatePicker("Set reminder", selection: $reminderDate.onChange(update), displayedComponents: [.date, .hourAndMinute])
                        .padding(.bottom)
                    
                    Button(action: {
                        scheduleNotification()
                    }) {
                        HStack {
                            Image(systemName: "calendar")
                            Text("Set Reminder")
                        }
                        .font(.footnote)
                        .padding(10)
                    }
                    .accentColor(.primary)
                    .background(Color(red: 155/255, green: 183/255, blue: 212/255))
                    .cornerRadius(20)
                    .shadow(radius: 5)
                }
                .padding(.vertical, 5)
            }

            Section(header: Text("Custom project color")) {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Project.colors, id: \.self, content: colorButton)
                }
                .padding(.vertical)
            }

            // swiftlint:disable:next line_length
            Section(footer: Text("Closing a project moves it from Open to Closed Tab; deleting it removes the project entirely.")) {
                Button(project.closed ? "Reopen this project": "Close this project") {
                    project.closed.toggle()
                    update()
                }

                Button("Delete this project") {
                    showingDeleteConfirm.toggle()
                }
                .accentColor(.red)
            }
        }
        }
        .navigationTitle("Edit Project")
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showingDeleteConfirm) {
            Alert(title: Text("Delete project?"),
                  message: Text("Are you sure you want to delete this project? You will also delete all the items it contains."), // swiftlint:disable:this line_length
                  primaryButton: .default(Text("Delete"), action: delete),
                  secondaryButton: .cancel() )
        }
    }
    

    func update() {
        project.title = title
        project.detail = detail
        project.color = color
        project.dueDate = dueDate
        project.reminderDate = reminderDate
    }

    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()
    }

    func colorButton(for item: String) -> some View {
        ZStack {
            Color(item)
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(6)

            if item == color {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            color = item
            update()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(
            item == color
                ? [.isButton, .isSelected]
                : .isButton
        )
        .accessibilityLabel(LocalizedStringKey(item))
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "\(project.title ?? "Project") due soon"

        
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

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView(project: Project.example)
    }
}
