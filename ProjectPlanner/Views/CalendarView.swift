//
//  CalendarView.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 4/28/21.
//

import SwiftUI
import SwiftUICharts

struct CalendarView: View {
    static let tag: String? = "Calendar"
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 200)
            LineView(data: [12, 22, 5, 35, 78, 45], title: "Line Chart")
            
            Spacer()
        }
    }
}

    struct CalendarView_Previews: PreviewProvider {
        static var previews: some View {
            CalendarView()
    }
}
