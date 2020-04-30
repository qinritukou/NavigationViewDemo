//
//  ContentView.swift
//  NavigationViewDemo
//
//  Created by Lihong Chen on 2020/04/30.
//  Copyright © 2020 Lihong Chen. All rights reserved.
//

import SwiftUI


class User: ObservableObject {
    @Published var score = 0
}

struct ResultView: View {
    var choice: String
    
    var body: some View {
        Text("You choose \(choice)")
    }
}

struct ChangeView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack {
            Text("Score: \(user.score)")
            Button("Increase") {
                self.user.score += 1
            }
        }
    }
}


struct ContentView: View {
    @State private var selection: String? = nil
    @State private var score = 0
    @State private var fullScreeen = false
    @ObservedObject var user = User()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
//                Text("Score: \(score)")
//                .navigationBarTitle("Navigation", displayMode: .inline)
//                .navigationBarItems(
//                    leading: Button("Substract 1") {
//                        self.score -= 1
//                    },
//                    trailing: Button("Add 1") {
//                        self.score += 1
//                })
                    
                Button("Toggle Full Screen") {
                    self.fullScreeen.toggle()
                }
                .navigationBarTitle("Toggle Full Screen", displayMode: .inline)
                .navigationBarHidden(fullScreeen)
                
                
                NavigationLink(destination: Text("Second View")) {
                    Image("hws").renderingMode(.original)
                }
                
                NavigationLink(destination: ResultView(choice: "Heads")) {
                    Text("Choose Heads")
                }

                NavigationLink(destination: ResultView(choice: "Tails")) {
                    Text("Choose Tails")
                }
                
                NavigationLink(destination: Text("Second View"), tag: "Second", selection: $selection) { EmptyView() }
                NavigationLink(destination: Text("Third View"), tag: "Third", selection: $selection) { EmptyView() }
                
                Button("Tap to show second") {
                    self.selection = "Second"
                }
                
                Button("Tap to show third") {
                    self.selection = "Third"
                }
                
                Text("Global Score: \(user.score)")
                    

                NavigationLink(destination: ChangeView()) {
                    Text("Show Detail View")
                }

            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
            }
        }
        .environmentObject(user)
        .statusBar(hidden: fullScreeen)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
