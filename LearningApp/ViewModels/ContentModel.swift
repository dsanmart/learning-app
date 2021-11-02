//
//  ContentModel.swift
//  LearningApp
//
//  Created by Diego Sanmartin on 02/11/2021.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    var styleData:Data?
    
    init() {
        getLocalData()
    }
    
    func getLocalData() {
        // Get ur to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode the json into an array of module
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData) // Decode it into an array of Module. Use self to pass the type
            
            // Assign parsed modules to published modules property
            self.modules = modules
            
        } catch {
            
            // Log Error
            print("Couldn't parse local data")
        }
        
        // Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "json")
        
        do {
            // Read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData

        } catch {
            // log error
            print("Couldn't parse style data")
        }
    }
    
}
