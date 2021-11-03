//
//  HomeView.swift
//  LearningApp
//
//  Created by Diego Sanmartin on 02/11/2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView {
            VStack (alignment: .leading) {
                Text("What do you want to do today?")
                    .padding(.leading,20)
                ScrollView {
                    
                    LazyVStack(spacing: 20) {
                        
                        ForEach(model.modules) { module in
                            
                            NavigationLink(
                                destination: ContentView()
                                    .onAppear(perform: { model.beginModule(module.id)
                                        
                                    }), // This is to keep track of the module
                                tag: module.id,
                                selection: $model.currentContentSelected, // Sets the tag value to this variable
                                label: {
                                // Learning card
                                HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                            })
                            
                            NavigationLink(
                                destination: TestView()
                                    .onAppear(perform: {
                                        model.beginTest(module.id)
                                    }),
                                tag: module.id,
                                selection: $model.currentTestSelected,
                                label: {
                                    // Test card
                                    HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
                            })
                            
                            // This empty navigation link is a bug fix for IOS 14 (It's not necessary for ios 15 though)
                            /*
                            NavigationLink(destination: EmptyView()) {
                                EmptyView()
                            }
                             */
                            
                        }
                    }
                    .padding()
                    .accentColor(.black)
                }
            }
            .navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
