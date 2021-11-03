//
//  CodeTextView.swift
//  LearningApp
//
//  Created by Diego Sanmartin on 03/11/2021.
//

import SwiftUI

struct CodeTextView: UIViewRepresentable { // Protocol to create and manage a UIView object from the UIKit in your SwiftUI interface.
    
    @EnvironmentObject var model:ContentModel
    
    func makeUIView(context: Context) -> UITextView { // Creates the view object and configures its initial state.

        // Create and configure UIKit element
        let textView = UITextView()
        textView.isEditable = false
        
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        // Set the attributed text for the lesson
        textView.attributedText = model.lessonDescription
        
        // Scroll back to the top
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
}

struct CodeTextView_Previews: PreviewProvider {
    static var previews: some View {
        CodeTextView()
    }
}
