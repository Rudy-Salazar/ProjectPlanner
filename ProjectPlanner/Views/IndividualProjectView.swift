//
//  IndividualProjectView.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 2/8/21.
//

import SwiftUI
import CoreData

struct IndividualProjectView: View {
    @ObservedObject var project: Project
    
    @State private var sortOrder = Item.SortOrder.optimized
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Project.entity(), sortDescriptors: [], predicate: nil) var projects: FetchedResults<Project>
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text("\(project.projectTitle)")
                .font(.title)
            
            BiggerProgressBarView(project: project)
            
            HStack {
                Image(systemName: "alarm")
                Text("Due Date: \(project.projectDueDate, formatter: IndividualProjectView.taskDateFormat)")
                    .padding(.vertical)
            }
            
            List {
                ForEach(project.projectItems(using: sortOrder)) { item in
                    ItemRowView(project: project, item: item)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .background(Color.systemGroupedBackground.ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditProjectView(project: project)) {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                }
            }
        }
    }
}


struct IndividualProjectView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualProjectView(project: Project.example)
    }
}
