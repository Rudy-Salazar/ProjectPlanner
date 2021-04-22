//
//  ProgressBarView.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 2/2/21.
//

import SwiftUI

struct ProgressBarView: View {
    @ObservedObject var project: Project
    
    var body: some View {
        VStack {
            ProgressBar(project: project)
                .frame(width: 100.0, height: 100.0)
                .padding(5.0)
        }
    }
    
    struct ProgressBar: View {
        @ObservedObject var project: Project
        var body: some View {            
        let value = project.completionAmount
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 5.0)
                    .opacity(0.3)
                    .foregroundColor(Color(project.projectColor))
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(Double(min(value, 1.0))))
                    .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color(project.projectColor))
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)
                
                Text(String(format: "%.0f %%", min(value, 1.0)*100.0))
                    .bold()
            }
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(project: Project.example)
    }
}
