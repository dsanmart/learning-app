//
//  LearningApp.swift
//  LearningApp
//
//  Created by Diego Sanmartin on 02/11/2021.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
