//
//  ProjectSummaryView.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 2/1/21.
//

import SwiftUI

struct ProjectSummaryView: View {
    @ObservedObject var project: Project

    var body: some View {
    NavigationLink(destination: IndividualProjectView(project: project)) {
            VStack(alignment: .center) {
                Text(project.projectTitle)
                    .font(.title2)
                    .foregroundColor(.primary)
                
                ProgressBarView.init(project: project)
                
                Text("\(project.projectItems.count) items")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.secondarySystemGroupedBackground)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 5)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(project.label)
        }
    }
}

