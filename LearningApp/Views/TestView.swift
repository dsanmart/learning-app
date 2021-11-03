//
//  TestView.swift
//  LearningApp
//
//  Created by Diego Sanmartin on 03/11/2021.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {

        if model.currentQuestion != nil {
            
            VStack {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                // Question
                CodeTextView()
                
                // Answers
                
                // Button
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        } else {
            // Test hasn't loaded yet
            ProgressView() // Indicates we currently don't have a question to show
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
