//
//  BiggerProgressBarView.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 2/8/21.
//

import SwiftUI

struct BiggerProgressBarView: View {
    @ObservedObject var project: Project
    
    var body: some View {
        VStack {
            BiggerProgressBar(project: project)
                .frame(width: 200.0, height: 200.0)
                .padding(5)
        }
    }
    
    struct BiggerProgressBar: View {
        @ObservedObject var project: Project
        var body: some View {
        let value = project.completionAmount
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(Color(project.projectColor))
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(Double(min(value, 1.0))))
                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color(project.projectColor))
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)
                                    
                Text(String(format: "%.0f %%", min(value, 1.0)*100.0))
                    .font(.title)
                    .bold()
            }
        }
    }
}
struct BiggerProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        BiggerProgressBarView(project: Project.example)
    }
}
