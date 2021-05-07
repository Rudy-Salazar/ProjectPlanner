//
//  ContentView.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 2/1/21.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedView") var selectedView: String?
    
    @AppStorage("WelcomeView") var isWelcomeScreenShowing = true
    //@State private var isWelcomeScreenShowing = true
    
    var body: some View {
        TabView(selection: $selectedView) {
            HomeView()
                .tag(HomeView.tag)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            ProjectsView(showClosedProjects: false)
                .tag(ProjectsView.openTag)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Open")
                }

            ProjectsView(showClosedProjects: true)
                .tag(ProjectsView.closedTag)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Closed")
                }
            
            CalendarView()
                .tag(CalendarView.tag)
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                    Text("Progress")
                }

//            AwardsView()
//                .tag(AwardsView.tag)
//                .tabItem {
//                    Image(systemName: "rosette")
//                    Text("Awards")
//                }
        }
        .sheet(isPresented: $isWelcomeScreenShowing) {
            WelcomeView(isWelcomeScreenShowing: $isWelcomeScreenShowing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
