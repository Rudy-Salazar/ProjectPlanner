//
//  EditItemView.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 2/1/21.
//

import SwiftUI

struct EditItemView: View {
    let item: Item

    @EnvironmentObject var dataController: DataController

    @State private var title: String
    @State private var detail: String
    @State private var priority: Int
    @State private var completed: Bool
    @State private var completedItemCount: Int
//    @Binding private var completedItemCount: Int
    

    init(item: Item) {
        self.item = item

        _title = State(wrappedValue: item.itemTitle)
        _detail = State(wrappedValue: item.itemDetail)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)
        _completedItemCount = State(wrappedValue: Int(item.completedItemCount))
        
    }

    var body: some View {
        Form {
            Section(header: Text("Basic settings")) {
                TextField("Item name", text: $title.onChange(update))
                TextField("Description", text: $detail.onChange(update))
            }

            Section(header: Text("Priority")) {
                Picker("Priority", selection: $priority.onChange(update)) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section {
                Toggle("Mark Completed", isOn: $completed.onChange(update))
            }
            .onTapGesture {
                itemCount()
                update()
            }
            
            VStack {
                Text("This is the completed item \(completedItemCount)")
            }
        }
        .navigationTitle("Edit Item")
        .onDisappear(perform: dataController.save)
    }

    func update() {
        item.project?.objectWillChange.send()
        item.title = title
        item.detail = detail
        item.priority = Int16(priority)
        item.completed = completed
        item.completedItemCount = Int16(completedItemCount)
    }
    
    func itemCount() {
        if completed == false {
            completedItemCount += 1
        }
    }
}


struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item.example)
    }
}
