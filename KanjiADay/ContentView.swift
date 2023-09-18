//
//  ContentView.swift
//  Kanji A Day
//
//  Created by Chris on 3/28/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State var showSettings = false
    @State var grades = [1, 2, 3, 4, 5, 6, 7]
    @State var currState: Int = UserDefaults.standard.integer(forKey: "curr_state")
    
    var body: some View {
        NavigationStack{
            ZStack {
                switch currState {
                case 1:
                    VStack{
                        Spacer()
                        
                        NavigationLink("show pane"){
                            HomeJP(showSettings: $showSettings, Grades: $grades)
                                            .offset(x: showSettings ? -UIScreen.main.bounds.width/2 : 0)
                                            .disabled(showSettings)
                                            .animation(.easeIn(duration: 0.3))
                        }
                    }

                    .navigationTitle("NAV")

                case 2:
                    HomeView2(showSettings: $showSettings, grades: $grades)
                case 3:
                    HomeView3(showSettings: $showSettings, grades: $grades)
                case 4:
                    HomeView4(showSettings: $showSettings, grades: $grades)
                default:

                        HomeJP(showSettings: $showSettings, Grades: $grades)
                                        .offset(x: showSettings ? -UIScreen.main.bounds.width/2 : 0)
                                        .disabled(showSettings)
                                        .animation(.easeIn(duration: 0.3))

                }
                
                if showSettings {
                    SettingsView(showSettings: $showSettings, GradesJP: $grades)
                        .transition(.move(edge: .trailing))
                        .animation(.easeOut(duration: 0.3))
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HomeView2: View {
    @Binding var showSettings: Bool
    @Binding var grades: [Int]
    
    var body: some View {
        // Home View 2 implementation
        Text("Home View 2")
    }
}

struct HomeView3: View {
    @Binding var showSettings: Bool
    @Binding var grades: [Int]
    
    var body: some View {
        // Home View 3 implementation
        Text("Home View 3")
    }
}

struct HomeView4: View {
    @Binding var showSettings: Bool
    @Binding var grades: [Int]
    
    var body: some View {
        // Home View 4 implementation
        Text("Home View 4")
    }
}
