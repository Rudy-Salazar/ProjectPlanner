 //
//  WelcomeView.swift
//  ProjectPlanner
//
//  Created by Rodolfo Salazar on 2/1/21.
//

import SwiftUI

struct WelcomeView: View {
    @State var userName = ""
    @Binding var isWelcomeScreenShowing: Bool
    
    let info = [
        WelcomeData(image: "chart.bar", header: "Progress", text: "Create projects and check progress when completing each task."),
       
        WelcomeData(image: "calendar", header: "Reminder", text: "Set reminders and stay up \nto date with important  due dates."),
        
        WelcomeData(image: "slider.horizontal.3", header: "Customization", text: "Customize each project by choosing from a variety of colors.")
    ]
    
    var body: some View {
        ZStack {
            Color(red: 155/255, green: 183/255, blue: 212/255)
            .ignoresSafeArea(.all)
            VStack {
                Spacer()
                Text("Simple Planning")
                    .font(.largeTitle)
                    .bold()
                
                
                ForEach(info, id: \.self) { info in
                    WelcomeAppInfoView(image: info.image, header: info.header, text: info.text)
                }

                Spacer()
                    .frame(height: 20)
                
                Button(action: {
                    self.isWelcomeScreenShowing.toggle()
                }) {
                    Text("Continue")
                        .foregroundColor(.black)
                        .bold()
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 64)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                }
                Spacer()
               
            }
        
        }

    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(isWelcomeScreenShowing: Binding.constant(true))
    }
}

struct WelcomeAppInfoView: View {
    let image: String
    let header: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.largeTitle)
            
            VStack(alignment: .leading) {
                Text(header)
                    .bold()
                
                Text(text)
                    .foregroundColor(.white)
            }
            .frame(width: 240)
            .padding()
        }
    }
}

struct WelcomeData: Hashable {
    let image: String
    let header: String
    let text: String
}
