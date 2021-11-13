//
//  ContentModel.swift
//  LearningApp
//
//  Created by Diego Sanmartin on 02/11/2021.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    
    // Track of user's current selected module
    @Published var currentModule:Module?
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson:Lesson?
    var currentLessonIndex = 0
    
    // Current question
    @Published var currentQuestion:Question?
    var currentQuestionIndex = 0
    
    // Html Explanations
    @Published var codeText = NSAttributedString()
    var styleData:Data?
    
    // Current selected content and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    init() {
        // Parse local included json data
        getLocalData()
        
        // Download remote json file and parse data
        getRemoteData()
    }
    
    //MARK: Data Methods
    func getLocalData() {
        // Get url to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            do {
                // Try to decode the json into an array of module
                let jsonDecoder = JSONDecoder()
                let modules = try jsonDecoder.decode([Module].self, from: jsonData) // Decode it into an array of Module. Use self to pass the type
                
                // Assign parsed modules to published modules property
                self.modules = modules
            } catch {
                print("Couldn't decode local data", error)
            }
            
        } catch {
            
            // Log Error
            print("Couldn't parse local data")
        }
        
        // Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            // Read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData

        } catch {
            // log error
            print("Couldn't parse style data")
        }
    }
    
    func getRemoteData() {
        
        // String path
        let urlString = "https://dsanmart.github.io/learningapp-data/data2.json"
        
        // Create a url object
        let url = URL(string: urlString)
        
        guard url != nil else {
            // Couldn't create url
            return
        }
        
        // Create a url request object
        let request = URLRequest(url: url!)
        
        // Get the session and kick off the task
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in

            // Check if there's an error
            guard error == nil else {
                // There was an error
                return
            }
            
            do {
                // Create json decoder
                let decoder = JSONDecoder()
                
                // Decode
                let modules = try decoder.decode([Module].self, from: data!)
                
                // Append parsed modules into modules prooperty
                self.modules += modules
            }
            catch {
                // Couldn't parse json
                print("Couldn't parse online json")
            }
                
            
        }
        
        // Kick off data task
        dataTask.resume()
    }
    
    //MARK: Module navigation methods
    func beginModule(_ moduleid:Int) {
        
        // Find the index for this module id
        for index in 0..<modules.count {
            
            if modules[index].id == moduleid {
                
                // Found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    //MARK: Lesson navigation methods
    func beginLesson(_ lessonindex:Int) {
        
        // Check that the lesson index is within the range of module lessons
        if lessonindex < currentModule!.content.lessons.count {
                
            // Found the matching module
            currentLessonIndex = lessonindex
            
        } else {
            currentLessonIndex = 0
        }
        
        // Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
        // Set lesson explanation
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        // Advance the lesson
        currentLessonIndex += 1
        
        // Check that it is within range
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
           
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex] // Since currentLesson is a published property it will update it in the UI
            codeText = addStyling(currentLesson!.explanation)
            
        } else {
            
            // Reset the lesson state when it's out of range
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        
        return currentLessonIndex + 1 < currentModule!.content.lessons.count
        
    }
    
    //MARK: Question navigation methods
    func beginTest(_ moduleId:Int) {
        
        // Set the current module
        beginModule(moduleId)
            
        // Set the current question
        currentQuestionIndex = 0
        
        // If there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0 { // If there current module is nil don't set currentQuestion
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            // Set the question content as well
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    func nextQuestion() {
        
        // Advance the question index
        currentQuestionIndex += 1
        
        // Check that it's within the range of questions
        if currentQuestionIndex < currentModule!.test.questions.count {
            
            // Set the current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
        else {
            // If not, then reset the properties
            currentQuestionIndex = 0
            currentQuestion = nil
        }
        
    }
    
    // MARK: Code Styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add styling data
        if styleData != nil {
            data.append(styleData!)
        }
        
        // Add the html data
        data.append(Data(htmlString.utf8))
        
        // Convert to attributed string
        
        /*
        // Technique 1 (don't care about the error)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
            }
        */
        // Technique 2 (prints the error)
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            resultString = attributedString
        } catch {
            print("Couldn't turn html into attributed string")
        }
        
        return resultString
        
    }
    
}
