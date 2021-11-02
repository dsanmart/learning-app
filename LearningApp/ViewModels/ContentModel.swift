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
    
    
    var styleData:Data?
    
    init() {
        getLocalData()
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
}
